class CreateTipoLocals < ActiveRecord::Migration
  def change
    create_table :tipo_locals do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
