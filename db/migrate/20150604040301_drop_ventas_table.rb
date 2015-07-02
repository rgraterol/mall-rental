class DropVentasTable < ActiveRecord::Migration
  def up
    drop_table :ventas
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
