class CreateRolesMalls < ActiveRecord::Migration
  def change
    create_table :malls_roles, :id => false do |t|
      t.references :role, :mall
    end
    add_index :malls_roles, [:mall_id, :role_id]
  end
end
