class Arrendatario < ActiveRecord::Base
  belongs_to :actividad_economica
  belongs_to :local

  has_many :ventas
end
