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
  before_update :clean_canon_alquiler
  belongs_to :tienda

  validates :tipo_canon_alquiler, :archivo_contrato, presence: true

  mount_uploader :archivo_contrato, FileUploader

  enum tipo_canon_alquiler: [:canon_fijo, :canon_fijo_y_porcentaje_ventas, :porcentaje_de_ventas]

  def clean_canon_alquiler
    if self.tipo_canon_alquiler == "canon_fijo"
      self.porc_canon_ventas = nil
      self.monto_minimo_ventas = nil
    elsif self.tipo_canon_alquiler == "porcentaje_de_ventas"
      self.canon_fijo_ml = nil
      self.canon_fijo_usd = nil
    end
  end

  def fecha_inicio_fix
    self.fecha_inicio.strftime("%d/%m/%Y")
  end

  def fecha_fin_fix
    self.fecha_fin.strftime("%d/%m/%Y")
  end
end
