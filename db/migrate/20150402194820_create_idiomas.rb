class CreateIdiomas < ActiveRecord::Migration
  def change
    create_table :idiomas do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
