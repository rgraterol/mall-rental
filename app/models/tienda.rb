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
  has_one :nivel_mall, through: :local
  belongs_to :actividad_economica
  belongs_to :arrendatario
  has_one :mall, through: :arrendatario

  has_many :contrato_alquilers, dependent: :destroy
  accepts_nested_attributes_for :contrato_alquilers, allow_destroy: true, reject_if: :all_blank

  has_many :ventas, dependent: :destroy
  has_many :user_tiendas, dependent: :destroy
  has_many :users, through: :user_tiendas

  after_create :set_missing_attributes
  # after_update :set_missing_attributes

  validates :local_id, :actividad_economica_id, :arrendatario_id, presence: true

  def set_missing_attributes
    self.update(fecha_apertura: (self.contrato_alquilers.first.fecha_inicio rescue Date.today),
                abierta: true, fecha_fin_contrato_actual: (self.contrato_alquilers.last.fecha_inicio rescue Date.today))
  end

  def vencido?
    if self.contrato_alquilers.last.fecha_fin < Date.today
      return 'Si'
    else
      return 'No'
    end
  end

  def self.by_nivel_mall(nivel_mall_id)
    return where(nil) unless nivel_mall_id.present?
    where(nivel_malls: {id: nivel_mall_id})
  end

  def self.by_actividad_economica(actividad_economica_id)
    return where(nil) unless actividad_economica_id.present?
    where(actividad_economicas: {id: actividad_economica_id})
  end

  def self.by_vencimiento(vencido)
    return where(nil) unless vencido.present?
    if vencido == 'vencidos'
      return where("contrato_alquilers.fecha_fin < ?", Date.today)
    elsif vencido == 'vigentes'
      return where("contrato_alquilers.fecha_fin >= ?", Date.today)
    else
      where(nil)
    end
  end

end
