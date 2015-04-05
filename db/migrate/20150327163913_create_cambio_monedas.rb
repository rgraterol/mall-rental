class CreateCambioMonedas < ActiveRecord::Migration
  def change
    create_table :cambio_monedas do |t|
      t.date :fecha
      t.decimal :cambio_ml_x_usd

      t.timestamps
    end
  end
end
