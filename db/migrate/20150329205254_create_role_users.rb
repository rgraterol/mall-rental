class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :role_users do |t|

      t.timestamps
    end
  end
end
