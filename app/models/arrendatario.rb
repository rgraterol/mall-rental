# == Schema Information
#
# Table name: arrendatarios
#
#  id          :integer          not null, primary key
#  nombre      :string(255)
#  rif         :string(255)
#  direccion   :string(255)
#  telefono    :string(255)
#  nombre_rl   :string(255)
#  cedula_rl   :string(255)
#  email_rl    :string(255)
#  telefono_rl :string(255)
#  mall_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Arrendatario < ActiveRecord::Base
  belongs_to :mall

  has_many :tiendas, dependent: :destroy

  validates :nombre, :rif, :direccion, :telefono, :telefono_rl, :nombre_rl, :cedula_rl, :mall_id, presence: true

  def self.valid_arrendatarios(user)
    return Arrendatario.where(mall_id: user.mall_id)
  end
end
