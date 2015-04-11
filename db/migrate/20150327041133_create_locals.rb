class CreateLocals < ActiveRecord::Migration
  def change
    create_table :locals do |t|
      t.string :foto
      t.string :nro_local
      t.string :ubicacion_pasillo
      t.decimal :area
      t.boolean :propiedad_mall
      t.belongs_to :tipo_local, :nivel_mall, :mall, index:true

      t.timestamps
    end
  end
end
