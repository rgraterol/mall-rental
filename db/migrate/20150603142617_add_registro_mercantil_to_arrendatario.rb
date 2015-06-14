class AddRegistroMercantilToArrendatario < ActiveRecord::Migration
  def change
    add_column :arrendatarios, :registro_mercantil, :text
  end
end
