# == Schema Information
#
# Table name: contrato_alquilers
#
#  id                  :integer          not null, primary key
#  nro_contrato        :string(255)
#  fecha_inicio        :date
#  fecha_fin           :date
#  archivo_contrato    :string(255)
#  canon_fijo_ml       :decimal(, )
#  canon_fijo_usd      :decimal(, )
#  porc_canon_ventas   :decimal(, )
#  monto_minimo_ventas :decimal(, )
#  estado_contrato     :boolean
#  tipo_canon_alquiler :integer
#  tienda_id           :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class ContratoAlquiler < ActiveRecord::Base
  before_create :set_missing_attributes_create
  before_update :clean_canon_alquiler
  belongs_to :tienda
  has_many :ventas, through: :tienda
  has_one :mall, through: :tienda

  #TODO Validaciones
  # validates :tipo_canon_alquiler, :archivo_contrato, presence: true

  mount_uploader :archivo_contrato, FileUploader

 # enum tipo_canon_alquiler: [:fijo, :variable, :fijo_y_variable_venta_bruta, :fijo_y_variable_venta_neta, :exento]

  enum tipo_canon_alquiler: [:fijo, :variableVB, :variableVN, :fijo_y_variable_venta_bruta, :fijo_y_variable_venta_neta, :exonerado]

  def clean_canon_alquiler
    if self.tipo_canon_alquiler == "fijo"
      self.canon_fijo_usd = self.canon_fijo_ml / CambioMoneda.last.cambio_ml_x_usd
      self.porc_canon_ventas = 0
      self.monto_minimo_ventas = 0
    elsif self.tipo_canon_alquiler == "variable"
      self.canon_fijo_ml = 0
      self.canon_fijo_usd = 0
      self.monto_minimo_ventas = 0
      self.requerida_venta = true
    elsif self.tipo_canon_alquiler == "fijo_y_variable_venta_bruta" ||  self.tipo_canon_alquiler == "fijo_y_variable_venta_neta"
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
      return true if self.archivo_contrato.url.split('.').last == 'pdf' || !(self.archivo_contrato.url.nil?)
      return false
    end
  end
  #enum tipo_canon_alquiler: [:fijo, :variableVB, :variableVN, :fijo_y_variable_venta_bruta, :fijo_y_variable_venta_neta, :exonerado]

  def calculate_canon(contrato,vmt)

    if contrato.tipo_canon_alquiler == 'fijo'
      @canon_fijo = contrato.canon_fijo_ml
      @canon_x_ventas = 0
    elsif contrato.tipo_canon_alquiler == "variableVB"
      @monto_minimo_v = contrato.canon_fijo_ml/(contrato.porc_canon_ventas / 100)
      if vmt >= @monto_minimo_v
        @canon_x_ventas = (vmt - @monto_minimo_v)*(contrato.porc_canon_ventas/100)
      else
        @canon_x_ventas = 0
      end
    elsif contrato.tipo_canon_alquiler == "fijo_y_variable_venta_bruta" ||  contrato.tipo_canon_alquiler == "fijo_y_variable_venta_neta"
      @canon_fijo = contrato.canon_fijo_ml
      @monto_minimo_v = contrato.monto_minimo_ventas
      #raise @monto_minimo_v.inspect
      if(vmt.to_f >= @monto_minimo_v.to_f)
        @canon_x_ventas = (vmt - @monto_minimo_v)*(contrato.porc_canon_ventas/100)
      else
        @canon_x_ventas = 0
      end
    else
      @canon_fijo = 0
      @monto_minimo_v = 0
      @canon_x_ventas = 0
    end
    if (@canon_fijo.nil?)
      @canon_fijo = 0
    end
    if @canon_x_ventas.nil?
      @canon_x_ventas = 0
    end
    @canon_alquiler = @canon_fijo + @canon_x_ventas
    @obj = {
        'canon_fijo' => @canon_fijo,
        'canon_x_ventas' => @canon_x_ventas,
        'canon_alquiler' => @canon_alquiler
      }
    return  @obj
  end
end
