# == Schema Information
#
# Table name: tipo_locals
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TipoLocal < ActiveRecord::Base
  has_many :locals
  has_many :tiendas, through: :locals
  has_one :mall, through: :locals
  validates :tipo, inclusion: { in: ['Comercial','Empresarial']}
end
