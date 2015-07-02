# == Schema Information
#
# Table name: venta_mensuals
#
#  id                  :integer          not null, primary key
#  anio                :integer
#  mes                 :integer
#  monto               :float
#  monto_notas_credito :float            default(0.0)
#  monto_bruto         :float
#  monto_bruto_USD     :float
#  monto_costo_venta   :float            default(0.0)
#  monto_neto          :float            default(0.0)
#  monto_neto_USD      :float            default(0.0)
#  editable            :boolean          default(TRUE)
#  tienda_id           :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'test_helper'

class VentaMensualTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
