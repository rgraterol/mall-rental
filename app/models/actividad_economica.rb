# == Schema Information
#
# Table name: actividad_economicas
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  mall_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ActividadEconomica < ActiveRecord::Base
  belongs_to :mall
  has_many :arrendatarios
  validates :nombre, presence: true
end
