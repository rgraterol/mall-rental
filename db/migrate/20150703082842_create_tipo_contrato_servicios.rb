class CreateTipoContratoServicios < ActiveRecord::Migration
  def change
    create_table :tipo_contrato_servicios do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
