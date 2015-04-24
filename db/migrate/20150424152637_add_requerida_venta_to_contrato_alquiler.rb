class AddRequeridaVentaToContratoAlquiler < ActiveRecord::Migration
  def change
    add_column :contrato_alquilers, :requerida_venta, :boolean
  end
end
