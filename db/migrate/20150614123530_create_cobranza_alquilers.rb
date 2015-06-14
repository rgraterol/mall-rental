class CreateCobranzaAlquilers < ActiveRecord::Migration
  def change
    create_table :cobranza_alquilers do |t|
      t.string :nro_recibo
      t.date :fecha_recibo_cobro
      t.integer :anio_alquiler
      t.integer :mes_alquiler
      t.float :monto_canon_fijo, precision: 12, scale: 2, default: 0
      t.float :monto_canon_variable, precision: 12, scale: 2, default: 0
      t.float :monto_alquiler, precision: 12, scale: 2
      t.float :monto_alquiler_usd, precision: 12, scale: 2
      t.boolean :facturado, default: true
      t.float :saldo_deudor

      t.references :tienda, index: true

      t.timestamps
    end
  end
end
