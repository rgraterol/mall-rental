class CreateVentas < ActiveRecord::Migration
  def change
    create_table :ventas do |t|
      t.timestamp :fecha
      t.decimal :monto_ml
      t.decimal :monto_usd

      t.references :inquilino, index: true

      t.timestamps
    end
  end
end
