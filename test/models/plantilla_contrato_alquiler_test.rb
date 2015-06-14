# == Schema Information
#
# Table name: plantilla_contrato_alquilers
#
#  id                     :integer          not null, primary key
#  nombre                 :string(255)
#  contenido              :text
#  mall_id                :integer
#  tipo_canon_alquiler_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#

require 'test_helper'

class PlantillaContratoAlquilerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
