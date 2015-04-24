class Banco < ActiveRecord::Base

  validates :nombre, presence: true
  has_many :cuenta_bancariums
end
