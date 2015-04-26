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
  has_many :tiendas, through: :locals

  def self.valid_nivel_malls(user)
    return NivelMall.where(mall_id: user.mall_id)
  end


end
