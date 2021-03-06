# == Schema Information
#
# Table name: pais
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  idioma_id  :integer
#  moneda_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Pai < ActiveRecord::Base
  has_many :malls
  belongs_to :idioma
  belongs_to :moneda
  validates :nombre, presence: true
  validates :nombre, uniqueness: true
end
