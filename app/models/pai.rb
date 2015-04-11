class Pai < ActiveRecord::Base
  has_many :malls
  belongs_to :idioma
  belongs_to :moneda
  validates :nombre, presence: true
  validates :nombre, uniqueness: true
end
