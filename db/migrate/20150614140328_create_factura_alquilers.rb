class CreateFacturaAlquilers < ActiveRecord::Migration
  def change
    create_table :factura_alquilers do |t|
      t.date :fecha
      t.string :nro_factura
      t.float :monto_factura, precision: 12, scale: 2, default: 0
      t.float :monto_abono, precision: 12, scale: 2, default: 0
      t.float :saldo_deudor, precision: 12, scale: 2
      t.boolean :canon_fijo

      t.references :cobranza_alquiler, index: true

      t.timestamps
    end
  end
end
