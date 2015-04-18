class CreateNumerosControls < ActiveRecord::Migration
  def change
    create_table :numeros_controls do |t|
      t.integer :nro_contrato

      t.timestamps
    end
  end
end
