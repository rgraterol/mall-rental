class DetallePagoAlquiler < ActiveRecord::Base
  belongs_to :pago_alquiler
  belongs_to :factura_alquiler
end
