class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 50, default: "", null: false

      t.timestamps
    end
  end

end
