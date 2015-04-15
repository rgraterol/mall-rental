class CreateMalls < ActiveRecord::Migration
  def change
    create_table :malls do |t|
      t.string :nombre
      t.string :abreviado
      t.string :rif
      t.string :direccion_fiscal
      t.string :telefono
      t.belongs_to :pai,index:true

      t.timestamps
    end
  end
end
