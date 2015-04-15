# == Schema Information
#
# Table name: ventas
#
#  id         :integer          not null, primary key
#  fecha      :datetime
#  monto_ml   :decimal(8, 2)
#  monto_usd  :decimal(8, 2)
#  tienda_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Venta < ActiveRecord::Base
  belongs_to :tienda
end
