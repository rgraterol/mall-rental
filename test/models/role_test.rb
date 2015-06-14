# == Schema Information
#
# Table name: roles
#
#  id               :integer          not null, primary key
#  name             :string(50)       default(""), not null
#  role_type        :integer          default(0), not null
#  created_at       :datetime
#  updated_at       :datetime
#  tipo_servicio_id :integer
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
