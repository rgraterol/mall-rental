class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 50, default: "", null: false
      t.integer :role_type, default: 0 , null: false
      t.timestamps
    end
  end

end
