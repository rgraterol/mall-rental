class AddCamposToLocals < ActiveRecord::Migration
  def change
    add_column :locals, :area_planta, :decimal, default: 0
    add_column :locals, :area_terraza, :decimal, default: 0
    add_column :locals, :area_mezanina, :decimal, default: 0
    add_column :locals, :tipo_estado_local, :integer
    remove_column :locals, :area, :decimal
    remove_column :locals, :propiedad_mall, :boolean
  end
end

