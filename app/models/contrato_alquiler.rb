# == Schema Information
#
# Table name: contrato_alquilers
#
#  id                  :integer          not null, primary key
#  nro_contrato        :string(255)
#  .form-group        :date
#  fecha_fin           :date
#  archivo_contrato    :string(255)
#  canon_fijo_ml       :decimal(, )
#  canon_fijo_usd      :decimal(, )
#  porc_canon_ventas   :decimal(, )
#  monto_minimo_ventas :decimal(, )
#  estado_contrato     :boolean
#  tipo_canon_alquiler :string(255)
#  arrendatario_id     :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class ContratoAlquiler < ActiveRecord::Base
  belongs_to :tienda

  enum tipo_canon_alquiler: [:canon_fijo, :canon_fijo_y_porcentaje_ventas, :porcentaje_de_ventas]
end
