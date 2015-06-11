class CreatePlantillaContratoAlquilers < ActiveRecord::Migration
  def change
    create_table :plantilla_contrato_alquilers do |t|
      t.string :nombre
      t.text :contenido
      t.references :mall, index: true
      t.references :tipo_canon_alquiler, index: true

      t.timestamps
    end
  end
end
