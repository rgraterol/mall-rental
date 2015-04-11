class CreateActividadEconomicas < ActiveRecord::Migration
  def change
    create_table :actividad_economicas do |t|
      t.string :nombre
      t.belongs_to :mall, index:true
      t.timestamps
    end
  end
end
