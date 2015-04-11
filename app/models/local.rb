class Local < ActiveRecord::Base
  belongs_to :mall
  belongs_to :nivel_mall
  belongs_to :tipo_local
  validates :tipo_local_id, :nro_local, :area, presence: true
  validates :area, numericality: true
  validates :nro_local, uniqueness: true, numericality: true
  validates_numericality_of :nro_local, :only_integer => true,
                            :message => "Solo se permite números enteros."

  mount_uploader :foto, AvatarUploader
end
