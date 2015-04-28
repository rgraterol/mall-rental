class CuentaBancarium < ActiveRecord::Base
  belongs_to :banco
  has_many :pago_alquilers
  has_many :malls
end
