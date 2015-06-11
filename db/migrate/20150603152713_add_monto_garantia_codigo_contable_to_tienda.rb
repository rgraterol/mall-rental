class AddMontoGarantiaCodigoContableToTienda < ActiveRecord::Migration
  def change
    add_column :tiendas, :monto_garantia, :decimal, scale: 2, precision: 30
    add_column :tiendas, :monto_garantia_usd, :decimal, scale: 2, precision: 30
    add_column :tiendas, :codigo_contable, :string
  end
end
