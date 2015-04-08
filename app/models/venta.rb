# == Schema Information
#
# Table name: ventas
#
#  id           :integer          not null, primary key
#  fecha        :datetime
#  monto_ml     :decimal(, )
#  monto_usd    :decimal(, )
#  inquilino_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Venta < ActiveRecord::Base
  belongs_to :inquilino
end
