class CreateDetallePagoAlquilers < ActiveRecord::Migration
  def change
    create_table :detalle_pago_alquilers do |t|
      t.float :monto, precision: 12, scale: 2, default: 0

      t.references :pago_alquiler, index: true
      t.references :factura_alquiler, index: true

      t.timestamps
    end
  end
end
