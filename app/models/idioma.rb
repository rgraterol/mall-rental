class Idioma < ActiveRecord::Base
  has_many :pais
  validates :nombre, uniqueness: true
  validates :nombre, presence: true
  validates :nombre, inclusion: { in: ['Español', 'Inglés', 'Portugués']}
end
