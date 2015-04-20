class AddEditableToVentas < ActiveRecord::Migration
  def change
    add_column :ventas, :editable, :boolean, :default => true
  end
end
