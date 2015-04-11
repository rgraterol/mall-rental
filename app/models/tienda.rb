class Tienda < ActiveRecord::Base
  belongs_to :local
  belongs_to :actividad_economica
  belongs_to :arrendatario
end
