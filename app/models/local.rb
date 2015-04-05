# == Schema Information
#
# Table name: locals
#
#  id                :integer          not null, primary key
#  foto              :string(255)
#  nro_local         :string(255)
#  direccion         :string(255)
#  ubicacion_pasillo :string(255)
#  area              :decimal(, )
#  propiedad_mall    :boolean
#  tipo_local_id     :integer
#  nivel_mall_id     :integer
#  mall_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Local < ActiveRecord::Base
  belongs_to :mall
  belongs_to :nivel_mall
  belongs_to :tipo_local
  validates :tipo_local_id, :nro_local, :direccion, :area, :propiedad_mall, presence: true
  validates :area, numericality: true
  validates :nro_local, :ubicacion_pasillo, uniqueness: true
end
