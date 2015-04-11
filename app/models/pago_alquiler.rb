# == Schema Information
#
# Table name: pago_alquilers
#
#  id                    :integer          not null, primary key
#  fecha                 :date
#  monto_canon_fijo_ml   :string(255)
#  decimal               :string(255)
#  monto_canon_fijo_usd  :decimal(, )
#  monto_porc_ventas_ml  :decimal(, )
#  monto_porc_ventas_usd :decimal(, )
#  mes_alquiler          :integer
#  ano_alquiler          :integer
#  inquilino_id          :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class PagoAlquiler < ActiveRecord::Base
  belongs_to :contrato_alquiler
end
