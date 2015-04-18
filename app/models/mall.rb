# == Schema Information
#
# Table name: malls
#
#  id               :integer          not null, primary key
#  nombre           :string(255)
#  abreviado        :string(255)
#  rif              :string(255)
#  direccion_fiscal :string(255)
#  telefono         :string(255)
#  pai_id           :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Mall < ActiveRecord::Base
  has_many :nivel_malls, dependent: :destroy
  belongs_to :pai
  has_many :actividad_economicas, dependent: :destroy
  has_many :users
  has_many :roles, through: :users
  has_many :locals, dependent: :destroy
  has_many :arrendatarios, dependent: :destroy
  has_many :tiendas, through: :arrendatarios, dependent: :destroy
  has_many :user_tiendas, through: :tiendas, dependent: :destroy
  has_many :contrato_alquilers, through: :tiendas, dependent: :destroy

  validates :nombre, :abreviado, :rif, :direccion_fiscal, :telefono, presence: true
  validates :rif, uniqueness: true


  def self.malls_without_admin
    return Mall.where.not(id: Mall.joins(:users).merge(User.joins(:role).where(roles: {role_type: Role.role_types[:administrador_cliente]})))
  end
end
