class CreateContratoAlquilers < ActiveRecord::Migration
  def change
    create_table :contrato_alquilers do |t|
      t.string :nro_contrato
      t.date :fecha_inicio
      t.date :fecha_fin
      t.string :archivo_contrato
      t.decimal :canon_fijo_ml, default: 0
      t.decimal :canon_fijo_usd, default: 0
      t.decimal :porc_canon_ventas, default: 0
      t.decimal :monto_minimo_ventas, default: 0
      t.boolean :estado_contrato
      t.integer :tipo_canon_alquiler

      t.references :tienda, index: true

      t.timestamps
    end
  end
end
