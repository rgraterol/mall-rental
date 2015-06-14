# == Schema Information
#
# Table name: locals
#
#  id                :integer          not null, primary key
#  foto              :string(255)
#  nro_local         :string(255)
#  ubicacion_pasillo :string(255)
#  tipo_local_id     :integer
#  nivel_mall_id     :integer
#  mall_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  area_planta       :decimal(, )      default(0.0)
#  area_terraza      :decimal(, )      default(0.0)
#  area_mezanina     :decimal(, )      default(0.0)
#  tipo_estado_local :integer
#


class Local < ActiveRecord::Base
  belongs_to :mall
  belongs_to :nivel_mall
  belongs_to :tipo_local
  has_one :tienda, dependent: :destroy
  validates :tipo_local_id, :nro_local, :area_planta, :area_terraza, :area_mezanina, presence: true
  validates :area_planta, :area_terraza, :area_mezanina, numericality: true
  validates :tipo_estado_local, presence: true

  mount_uploader :foto, AvatarUploader

  enum tipo_estado_local: [:Disponible, :Alquilado, :En_Reparacion, :Vendido]

  def self.valid_locals(user)
    return Local.joins(:mall).where(malls: {id: user.mall_id})
  end

  def self.valid_tipo_estado_local
    %w[Disponible Alquilado En_Reparacion Vendido]
  end
end
