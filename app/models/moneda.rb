class Moneda < ActiveRecord::Base
  has_many :pais
  validates :nombre, uniqueness: true
  validates :nombre, presence: true
  validates :nombre, inclusion: { in: ['Bolívares', 'Dolares', 'Euros']}
end
