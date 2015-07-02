class CreateTipoServicios < ActiveRecord::Migration
  def change
    create_table :tipo_servicios do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
