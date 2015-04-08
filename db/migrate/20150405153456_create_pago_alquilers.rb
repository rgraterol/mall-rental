class CreatePagoAlquilers < ActiveRecord::Migration
  def change
    create_table :pago_alquilers do |t|
      t.date :fecha
      t.string :monto_canon_fijo_ml
      t.string :decimal
      t.decimal :monto_canon_fijo_usd
      t.decimal :monto_porc_ventas_ml
      t.decimal :monto_porc_ventas_usd
      t.integer :mes_alquiler
      t.integer :ano_alquiler

      t.references :contrato_alquiler, index: true

      t.timestamps
    end
  end
end
