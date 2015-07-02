class AddTipoServicioToRol < ActiveRecord::Migration
  def change
    add_reference :roles, :tipo_servicio, index: true
  end
end
