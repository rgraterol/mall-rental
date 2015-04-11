class TipoLocal < ActiveRecord::Base
  has_many :locals
  validates :tipo, inclusion: { in: ['Comercial','Empresarial']}
end
