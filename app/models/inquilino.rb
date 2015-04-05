class Inquilino < ActiveRecord::Base
  belongs_to :actividad_economica
  belongs_to :local
  has_many :canon_alquilers
  has_many :ventas

  enum tipo_canon_alquiler: [:canon_fijo, :canon_fijo_porc_ventas, :porcentaje_ventas]

end
