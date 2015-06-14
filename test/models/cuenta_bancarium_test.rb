# == Schema Information
#
# Table name: cuenta_bancaria
#
#  id            :integer          not null, primary key
#  nro_cta       :string(255)
#  tipo_cuenta   :string(255)
#  beneficiario  :string(255)
#  doc_identidad :string(255)
#  banco_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  mall_id       :integer
#

require 'test_helper'

class CuentaBancariumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
