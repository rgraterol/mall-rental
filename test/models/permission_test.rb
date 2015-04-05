# == Schema Information
#
# Table name: permissions
#
#  id            :integer          not null, primary key
#  subject_class :string(60)       default("")
#  action        :string(50)       default(""), not null
#  name          :string(50)       default(""), not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
