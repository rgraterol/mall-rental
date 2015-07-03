class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :RIF
      t.string :direccion
      t.string :telefono
      t.string :nombre_rl
      t.string :profesion_rl
      t.string :cedula_rl
      t.string :email_rl
      t.string :telefono_rl
      t.string :nombre_contacto
      t.string :profesion_contacto
      t.string :cedula_contacto
      t.string :email_contacto
      t.string :telefono_contacto
      t.references :mall, index: true
      t.references :tipo_servicio, index: true

      t.timestamps
    end
  end
end
