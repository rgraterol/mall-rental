class CreateNroRecibos < ActiveRecord::Migration
  def change
    create_table :nro_recibos do |t|
      t.integer :numero

      t.timestamps
    end
  end
end
