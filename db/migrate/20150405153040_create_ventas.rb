class CreateVentas < ActiveRecord::Migration
  def change
    create_table :ventas do |t|
      t.timestamp :fecha
      t.decimal :monto_ml, precision: 12, scale: 2
      t.decimal :monto_usd, precision: 12, scale: 2

      t.references :tienda, index: true

      t.timestamps
    end
  end
end
