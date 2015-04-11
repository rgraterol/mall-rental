# == Schema Information
#
# Table name: tiendas
#
#  id                        :integer          not null, primary key
#  nombre                    :string(255)
#  fecha_apertura            :date
#  fecha_cierre              :date
#  abierta                   :boolean
#  fecha_fin_contrato_actual :date
#  local_id                  :integer
#  actividad_economica_id    :integer
#  arrendatario_id           :integer
#  created_at                :datetime
#  updated_at                :datetime
#

class Tienda < ActiveRecord::Base
  belongs_to :local
  belongs_to :actividad_economica
  belongs_to :arrendatario

  has_many :contrato_alquilers, dependent: :destroy
  accepts_nested_attributes_for :contrato_alquilers, allow_destroy: true

  has_many :ventas
end
