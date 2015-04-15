class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :subject_class, limit: 60, default: ""
      t.string :action, null: false, limit: 50, default:""
      t.string :name, null: false, limit: 50, default:""

      t.timestamps
    end

    create_table :permissions_roles, :id => false do |t|
      t.references :role, :permission
    end

    add_index :permissions_roles, [:permission_id, :role_id]
  end
end
