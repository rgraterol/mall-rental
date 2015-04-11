class Mall < ActiveRecord::Base
  has_many :locals
  has_many :nivel_malls
  belongs_to :pai
  has_many :actividad_economicas
  validates :nombre, :abreviado, :rif, :direccion_fiscal, :telefono, presence: true
  validates :rif, uniqueness: true
end
