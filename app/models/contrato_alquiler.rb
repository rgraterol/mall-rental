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
#  tipo_canon_alquiler :string(255)
#  arrendatario_id     :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class ContratoAlquiler < ActiveRecord::Base
  belongs_to :tienda
end
