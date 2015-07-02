class CreateVentaDiaria < ActiveRecord::Migration
  def change
    create_table :venta_diaria do |t|
      t.date :fecha
      t.float :monto, precision: 12, scale: 2
      t.float :monto_notas_credito, precision: 12, scale: 2, default: 0
      t.float :monto_bruto, precision: 12, scale: 2
      t.float :monto_bruto_usd, precision: 12, scale: 2
      t.float :monto_costo_venta, precision: 12, scale: 2, default: 0
      t.float :monto_neto, precision: 12, scale: 2, default: 0
      t.float :monto_neto_usd, precision: 12, scale: 2, default: 0
      t.boolean :editable, default: true

      t.references :venta_mensual, index: true
      t.timestamps
    end
  end
end
