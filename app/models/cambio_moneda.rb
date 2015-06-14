# == Schema Information
#
# Table name: cambio_monedas
#
#  id              :integer          not null, primary key
#  fecha           :date
#  cambio_ml_x_usd :decimal(, )
#  created_at      :datetime
#  updated_at      :datetime
#  mall_id         :integer
#


class CambioMoneda < ActiveRecord::Base
  validates :cambio_ml_x_usd, numericality: true, presence: true
  has_many :malls
end
