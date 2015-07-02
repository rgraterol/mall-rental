class CreateDocumentoVentas < ActiveRecord::Migration
  def change
    create_table :documento_ventas do |t|
      t.string :titulo
      t.string :nombre
      t.references :venta_mensual, index: true

      t.timestamps
    end
  end
end
