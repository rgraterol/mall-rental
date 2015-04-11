# == Schema Information
#
# Table name: nivel_malls
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  mall_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class NivelMall < ActiveRecord::Base
  belongs_to :mall
  has_many :locals
end
