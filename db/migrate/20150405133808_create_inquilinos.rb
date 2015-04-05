class CreateInquilinos < ActiveRecord::Migration
  def change
    create_table :inquilinos do |t|
      t.string :nombre
      t.string :rif
      t.string :telefono
      t.date :fecha_inicio
      t.date :fecha_fin
      t.string :representante_legal
      t.string :archivo_contrato

      t.timestamps
    end
  end
end
