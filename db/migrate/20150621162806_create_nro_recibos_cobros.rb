class CreateNroRecibosCobros < ActiveRecord::Migration
  def change
    create_table :nro_recibos_cobros do |t|
      t.integer :numero

      t.timestamps
    end
  end
end
