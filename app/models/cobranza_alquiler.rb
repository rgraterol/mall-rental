class CobranzaAlquiler < ActiveRecord::Base
  belongs_to :tienda
  has_many :factura_alquilers

end
