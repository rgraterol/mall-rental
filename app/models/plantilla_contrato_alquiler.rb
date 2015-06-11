class PlantillaContratoAlquiler < ActiveRecord::Base
  belongs_to :mall
  belongs_to :tipo_canon_alquiler
end
