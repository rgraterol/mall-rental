class CreatePagoAlquilers < ActiveRecord::Migration
  def change
    create_table :pago_alquilers do |t|
      t.string :nro_recibo
      t.date :fecha_recibo_cobro
      t.integer :anio_alquiler
      t.integer :mes_alquiler
      t.decimal :monto_canon_fijo_ml
      t.decimal :monto_porc_ventas_ml
      t.decimal :monto_alquiler_ml
      t.decimal :monto_alquiler_usd
      t.boolean :pagado
      t.date :fecha_pago
      t.string :nro_cheque_confirmacion
      t.string :archivo_transferencia
      t.string :nombre_banco
      t.boolean :facturado
      t.string :nro_factura
      t.date :fecha_factura
      t.integer :tipo_pago

      t.references :contrato_alquiler, index: true
      t.references :tienda, index: true
      t.references :cuenta_bancarium, index: true

      t.timestamps
    end
  end
end

