# == Schema Information
#
# Table name: idiomas
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Idioma < ActiveRecord::Base
  has_many :pais
  validates :nombre, uniqueness: true
  validates :nombre, presence: true
  validates :nombre, inclusion: { in: ['Español', 'Inglés', 'Portugués']}
end
