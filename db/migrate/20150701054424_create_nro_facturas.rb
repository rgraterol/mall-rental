class CreateNroFacturas < ActiveRecord::Migration
  def change
    create_table :nro_facturas do |t|
      t.integer :numero

      t.timestamps
    end
  end
end
