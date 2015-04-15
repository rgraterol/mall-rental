class CreateCanonAlquilers < ActiveRecord::Migration
  def change
    create_table :canon_alquilers do |t|
      t.date :fecha
      t.decimal :canon_fijo_ml
      t.decimal :canon_fijo_usd
      t.decimal :porc_canon_ventas
      t.integer :monto_minimo_ventas
      t.timestamps
    end
  end
end
