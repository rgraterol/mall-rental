class CreateTiendas < ActiveRecord::Migration
  def change
    create_table :tiendas do |t|
      t.string :nombre
      t.date :fecha_apertura
      t.date :fecha_cierre
      t.boolean :abierta
      t.date :fecha_fin_contrato_actual
      t.references :local, index: true
      t.references :actividad_economica, index: true
      t.references :arrendatario, index: true

      t.timestamps
    end
  end
end
