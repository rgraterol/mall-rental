# == Schema Information
#
# Table name: ventas
#
#  id         :integer          not null, primary key
#  fecha      :datetime
#  monto_ml   :decimal(12, 2)
#  monto_usd  :decimal(12, 2)
#  tienda_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  editable   :boolean          default(TRUE)
#


class Venta < ActiveRecord::Base
  belongs_to :tienda
  has_one :nivel_mall, through: :tienda
  has_one :actividad_economica, through: :tienda
  has_many :contrato_alquilers, through: :tienda

  def intermensuales_vxa

  end
end
