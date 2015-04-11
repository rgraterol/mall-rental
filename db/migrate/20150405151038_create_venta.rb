class CreateVenta < ActiveRecord::Migration
  def change
    create_table :venta do |t|
      t.timestamp :fecha
      t.decimal :monto_ml, presicion: 8, scale: 2
      t.decimal :monto_usd, presicion: 8, scale: 2

      t.references :inquilino

      t.timestamps
    end
  end
end
