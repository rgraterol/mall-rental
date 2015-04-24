class CuentaBancarium < ActiveRecord::Base
 # validates :tipo_canon_alquiler, :archivo_contrato, presence: true
  belongs_to :banco
  has_many :pago_alquilers
  has_many :malls
end
