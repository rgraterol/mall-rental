class AddRemoveColumnsToPagoAlquiler < ActiveRecord::Migration
  def change
    add_column :pago_alquilers, :monto, :decimal
    add_column :pago_alquilers, :monto_usd, :decimal
    add_column :pago_alquilers, :conciliado, :boolean, default: true

    remove_column :pago_alquilers, :fecha_recibo_cobro, :date
    remove_column :pago_alquilers, :anio_alquiler, :integer
    remove_column :pago_alquilers, :mes_alquiler, :integer
    remove_column :pago_alquilers, :monto_canon_fijo_ml, :decimal
    remove_column :pago_alquilers, :monto_porc_ventas_ml, :decimal
    remove_column :pago_alquilers, :monto_alquiler_ml, :decimal
    remove_column :pago_alquilers, :monto_alquiler_usd, :decimal
    remove_column :pago_alquilers, :facturado, :boolean
    remove_column :pago_alquilers, :nro_factura, :string
    remove_column :pago_alquilers, :fecha_factura, :date
    remove_column :pago_alquilers, :pagado, :boolean
    rename_column :pago_alquilers, :fecha_pago, :fecha
    rename_column :pago_alquilers, :nombre_banco, :banco_emisor

    remove_reference :pago_alquilers, :contrato_alquiler
    remove_reference :pago_alquilers, :tienda
  end
end