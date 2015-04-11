class Arrendatario < ActiveRecord::Base
  belongs_to :actividad_economica
  belongs_to :local

  has_many :ventas

  validates :nombre, :rif, :direccion, :telefono, :telefono_rl, :nombre_rl, :cedula_rl, :actividad_economica_id, :local_id, presence: true

end
