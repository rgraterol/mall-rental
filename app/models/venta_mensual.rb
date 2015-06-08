class VentaMensual < ActiveRecord::Base
  belongs_to :tienda
  has_many :venta_diariums
  has_many :documento_ventas

end
