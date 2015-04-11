class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :nombre
      t.belongs_to :idioma, :moneda, index:true

      t.timestamps
    end
  end
end
