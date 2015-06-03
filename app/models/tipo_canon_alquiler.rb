# == Schema Information
#
# Table name: tipo_canon_alquilers
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TipoCanonAlquiler < ActiveRecord::Base
  validates :tipo, inclusion: { in: [:fijo, :variable, :fijo_y_variable_venta_bruta, :fijo_y_variable_venta_neta, :exento]}
  has_many :plantilla_contrato_alquilers
end
