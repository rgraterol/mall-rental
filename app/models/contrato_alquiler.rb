class ContratoAlquiler < ActiveRecord::Base
  has_many :pago_alquilers
  belongs_to :arrendatario
end
