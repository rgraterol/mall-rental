class CreatePrecioServicios < ActiveRecord::Migration
  def change
    create_table :precio_servicios do |t|
      t.date :fecha
      t.float :precio_usd
      t.references :tipo_servicio, index: true
      t.references :tipo_contrato_servicio, index: true
      t.timestamps
    end
  end
end
