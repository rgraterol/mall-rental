# == Schema Information
#
# Table name: bancos
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Banco < ActiveRecord::Base

  validates :nombre, presence: true
  has_many :cuenta_bancariums
end
