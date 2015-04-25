class AddCamposToLocals < ActiveRecord::Migration
  def change
    add_column :locals, :area_planta, :decimal
    add_column :locals, :area_terraza, :decimal
    add_column :locals, :area_mezanina, :decimal
    add_column :locals, :tipo_estado_local, :integer
    remove_column :locals, :area, :decimal
    remove_column :locals, :propiedad_mall, :boolean

  end
end
