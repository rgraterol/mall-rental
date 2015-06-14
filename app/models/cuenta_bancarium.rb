# == Schema Information
#
# Table name: cuenta_bancaria
#
#  id            :integer          not null, primary key
#  nro_cta       :string(255)
#  tipo_cuenta   :string(255)
#  beneficiario  :string(255)
#  doc_identidad :string(255)
#  banco_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  mall_id       :integer
#

class CuentaBancarium < ActiveRecord::Base
  belongs_to :banco
  has_many :pago_alquilers
  has_many :malls
end
