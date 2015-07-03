# == Schema Information
#
# Table name: tipo_servicios
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TipoServicio < ActiveRecord::Base
  has_many :roles
  validates :tipo, inclusion: { in: ['mall','mall_rental', 'mall_condominio']}
  has_many :clientes

  def tipo_humanize
    self.tipo.humanize.titleize
  end
end
