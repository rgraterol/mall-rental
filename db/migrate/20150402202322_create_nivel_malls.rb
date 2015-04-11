class CreateNivelMalls < ActiveRecord::Migration
  def change
    create_table :nivel_malls do |t|
      t.string :nombre
      t.belongs_to :mall, index:true
      t.timestamps
    end
  end
end
