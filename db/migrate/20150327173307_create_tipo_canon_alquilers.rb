class CreateTipoCanonAlquilers < ActiveRecord::Migration
  def change
    create_table :tipo_canon_alquilers do |t|
      t.string :tipo
      t.timestamps
    end
  end
end
