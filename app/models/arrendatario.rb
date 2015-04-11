class Arrendatario < ActiveRecord::Base
  belongs_to :mall
  has_many :tiendas


  validates :nombre, :rif, :direccion, :telefono, :telefono_rl, :nombre_rl, :cedula_rl, :mall_id, presence: true

end
