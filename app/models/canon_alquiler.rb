# == Schema Information
#
# Table name: canon_alquilers
#
#  id                  :integer          not null, primary key
#  fecha               :date
#  canon_fijo_ml       :decimal(, )
#  canon_fijo_usd      :decimal(, )
#  porc_canon_ventas   :decimal(, )
#  monto_minimo_ventas :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class CanonAlquiler < ActiveRecord::Base
  validates :monto_minimo_ventas, numericality: { greater_than_or_equal_to: 0 }
  validates :canon_fijo_ml, numericality: { greater_than_or_equal_to: 0 }
  validates :canon_fijo_usd, numericality: true
  validates :porc_canon_ventas, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100  }
end
