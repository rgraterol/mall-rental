class CreateUserTiendas < ActiveRecord::Migration
  def change
    create_table :user_tiendas do |t|
      t.references :user, index: true
      t.references :tienda, index: true

      t.timestamps
    end
  end
end
