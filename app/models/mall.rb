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
  has_many :nivel_malls
  belongs_to :pai
  has_many :actividad_economicas
  has_many :users
  has_many :roles, through: :users
  has_many :locals
  has_many :arrendatarios

  validates :nombre, :abreviado, :rif, :direccion_fiscal, :telefono, presence: true
  validates :rif, uniqueness: true


  def self.malls_without_admin
    return Mall.where.not(id: Mall.joins(:users).merge(User.joins(:role).where(roles: {role_type: Role.role_types[:administrador_cliente]})))
  end
end
