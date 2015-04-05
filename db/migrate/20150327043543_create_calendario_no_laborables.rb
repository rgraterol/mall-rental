class CreateCalendarioNoLaborables < ActiveRecord::Migration
  def change
    create_table :calendario_no_laborables do |t|
      t.date :fecha
      t.string :motivo

      t.timestamps
    end
  end
end
