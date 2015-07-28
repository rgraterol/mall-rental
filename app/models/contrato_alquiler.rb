# == Schema Information
#
# Table name: contrato_alquilers
#
#  id                     :integer          not null, primary key
#  nro_contrato           :string(255)
#  fecha_inicio           :date
#  fecha_fin              :date
#  archivo_contrato       :string(255)
#  canon_fijo_ml          :decimal(30, 2)   default(0.0)
#  canon_fijo_usd         :decimal(30, 2)   default(0.0)
#  porc_canon_ventas      :decimal(30, 2)   default(0.0)
#  monto_minimo_ventas    :decimal(30, 2)   default(0.0)
#  estado_contrato        :boolean
#  tienda_id              :integer
#  created_at             :datetime
#  updated_at             :datetime
#  requerida_venta        :boolean
#  tipo_canon_alquiler_id :integer
#



class ContratoAlquiler < ActiveRecord::Base
  before_create :set_missing_attributes_create
  before_update :clean_canon_alquiler
  belongs_to :tienda
  has_many :ventas, through: :tienda
  has_one :mall, through: :tienda
  belongs_to :tipo_canon_alquiler

  #TODO Validaciones
  validates :archivo_contrato, presence: true
  validates :tipo_canon_alquiler_id, presence: true

  mount_uploader :archivo_contrato, FileUploader

  # enum tipo_canon_alquiler: [:fijo, :variableVB, :variableVN, :fijo_y_variable_venta_bruta, :fijo_y_variable_venta_neta, :exonerado]

  def clean_canon_alquiler
    if self.tipo_canon_alquiler.tipo == "fijo"
      self.canon_fijo_usd = self.canon_fijo_ml / CambioMoneda.last.cambio_ml_x_usd
      self.porc_canon_ventas = 0
      self.monto_minimo_ventas = 0
    elsif self.tipo_canon_alquiler.tipo == "variable_venta_bruta" || self.tipo_canon_alquiler.tipo == "variable_venta_neta"
      self.canon_fijo_ml = 0
      self.canon_fijo_usd = 0
      self.monto_minimo_ventas = 0
      self.requerida_venta = true
    elsif self.tipo_canon_alquiler.tipo == "fijo_y_variable_venta_bruta" ||  self.tipo_canon_alquiler.tipo == "fijo_y_variable_venta_neta"
      self.canon_fijo_usd = self.canon_fijo_ml / CambioMoneda.last.cambio_ml_x_usd
      self.monto_minimo_ventas = self.canon_fijo_ml / (self.porc_canon_ventas / 100)
      self.requerida_venta = true
    else
      self.canon_fijo_ml = 0
      self.canon_fijo_usd = 0
      self.porc_canon_ventas = 0
      self.monto_minimo_ventas = 0
      self.requerida_venta = false
    end
  end

  def set_missing_attributes_create
    self.nro_contrato = NumerosControl.get_nro_contrato
    self.canon_fijo_usd = self.canon_fijo_ml / CambioMoneda.last.cambio_ml_x_usd if self.canon_fijo_ml.present? && self.canon_fijo_ml != 0
    self.monto_minimo_ventas = self.canon_fijo_ml / (self.porc_canon_ventas / 100) if self.porc_canon_ventas.present? && porc_canon_ventas != 0 && self.canon_fijo_ml.present? && self.canon_fijo_ml != 0
    self.requerida_venta = true if self.porc_canon_ventas.present? && self.porc_canon_ventas != 0
  end

  def fecha_inicio_fix
    self.fecha_inicio.strftime("%d/%m/%Y")
  end

  def fecha_fin_fix
    self.fecha_fin.strftime("%d/%m/%Y")
  end

=begin #Codigo como estaba el de Ricardo
  def archivo_contrato_pdf?
    return true if self.archivo_contrato.url.split('.').last == 'pdf'
    return false
  end
=end

  def archivo_contrato_pdf? #cambios de Lery para hacer que funcione si no tiene archivo cargado.
    if self.archivo_contrato.url.nil?
      return false
    else
      return true if self.archivo_contrato.url.split('.').last == 'pdf'
      return false
    end
  end
  #enum tipo_canon_alquiler: [:fijo, :variableVB, :variableVN, :fijo_y_variable_venta_bruta, :fijo_y_variable_venta_neta, :exonerado]

  def self.calculate_canon(contrato,suma_monto_bruto,suma_monto_neto)
    tipo_contrato = contrato.tipo_canon_alquiler.tipo
    vmt = suma_monto_bruto if tipo_contrato == "variable_venta_bruta" || tipo_contrato == "fijo_y_variable_venta_bruta"
    vmt = suma_monto_neto if tipo_contrato == "variable_venta_neta" || tipo_contrato == "fijo_y_variable_venta_neta"

    if tipo_contrato == 'fijo'
      canon_fijo = contrato.canon_fijo_ml
      canon_variable = 0
    elsif tipo_contrato == "variable_venta_bruta" || tipo_contrato == "variable_venta_neta"
      canon_fijo = 0
      monto_minimo_v = contrato.monto_minimo_ventas
      if vmt >= monto_minimo_v
        canon_variable = (vmt - monto_minimo_v)*(contrato.porc_canon_ventas/100)
      else
        canon_variable = 0
      end
    elsif tipo_contrato == "fijo_y_variable_venta_bruta" ||  tipo_contrato == "fijo_y_variable_venta_neta"
      canon_fijo = contrato.canon_fijo_ml
      monto_minimo_v = contrato.monto_minimo_ventas

      if(vmt.to_f >= monto_minimo_v.to_f)
        canon_variable = (vmt - monto_minimo_v)*(contrato.porc_canon_ventas/100)
      else
        canon_variable = 0
      end
    else
      canon_fijo = 0
      canon_variable = 0
    end

    canon_fijo = 0 if canon_fijo.nil?
    canon_variable = 0 if canon_variable.nil?
    canon_alquiler = canon_fijo + canon_variable
    obj = {
        'canon_fijo' => canon_fijo,
        'canon_variable' => canon_variable,
        'canon_alquiler' => canon_alquiler
      }
    return  obj
  end

  def self.get_contrato_vigente(tienda)
    return self.where("estado_contrato = ? AND tienda_id = ?",true,tienda)
  end

  def self.get_tipo_canon(tienda)
    return self.find_by("estado_contrato = ? AND tienda_id = ?",true,tienda).tipo_canon_alquiler.tipo_nombre
  end



=begin
  def self.get_canons_xmes(mall,year,mes)
    canon_fijo = 0
    canon_variable = 0
    suma_canons = 0
    canons = Array.new
    mall.tiendas do |tienda|
      contrato = ContratoAlquiler.get_contrato_vigente(tienda)
      canon_fijo = contrato.canon_fijo
      canon_variable = contrato.monto_canon_variable
  end
=end
end
