class CreateContratoAlquilers < ActiveRecord::Migration
  def change
    create_table :contrato_alquilers do |t|
      t.string :nro_contrato
      t.date :fecha_inicio
      t.date :fecha_fin
      t.string :archivo_contrato
      t.decimal :canon_fijo_ml
      t.decimal :canon_fijo_usd
      t.decimal :porc_canon_ventas
      t.decimal :monto_minimo_ventas
      t.boolean :estado_contrato
      t.integer :tipo_canon_alquiler

      t.references :tienda, index: true

      t.timestamps
    end
  end
end
