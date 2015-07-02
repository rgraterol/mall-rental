# == Schema Information
#
# Table name: venta_diaria
#
#  id                  :integer          not null, primary key
#  fecha               :date
#  monto               :float
#  monto_notas_credito :float            default(0.0)
#  monto_bruto         :float
#  monto_bruto_usd     :float
#  monto_costo_venta   :float            default(0.0)
#  monto_neto          :float            default(0.0)
#  monto_neto_usd      :float            default(0.0)
#  editable            :boolean          default(TRUE)
#  venta_mensual_id    :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'test_helper'

class VentaDiariumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
