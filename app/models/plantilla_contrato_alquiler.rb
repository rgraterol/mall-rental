# == Schema Information
#
# Table name: plantilla_contrato_alquilers
#
#  id                     :integer          not null, primary key
#  nombre                 :string(255)
#  contenido              :text
#  mall_id                :integer
#  tipo_canon_alquiler_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class PlantillaContratoAlquiler < ActiveRecord::Base
  belongs_to :mall
  belongs_to :tipo_canon_alquiler
end
