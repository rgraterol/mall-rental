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
  has_one :mall, through: :arrendatario

  has_many :contrato_alquilers, dependent: :destroy
  accepts_nested_attributes_for :contrato_alquilers, allow_destroy: true, reject_if: :all_blank

  has_many :ventas, dependent: :destroy
  has_many :user_tiendas, dependent: :destroy
  has_many :users, through: :user_tiendas
  has_many :pago_alquilers

  after_create :set_missing_attributes
  # after_update :set_missing_attributes

  validates :local_id, :actividad_economica_id, :arrendatario_id, presence: true

  def set_missing_attributes
    self.update(fecha_apertura: '2015-01-01',
                abierta: true, fecha_fin_contrato_actual: '2015-12-30')
  end

  def vencido?
    if self.contrato_alquilers.last.fecha_fin < Date.today
      return 'Si'
    else
      return 'No'
    end
  end

end
