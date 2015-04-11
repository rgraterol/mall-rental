class CreateArrendatarios < ActiveRecord::Migration
  def change
    create_table :arrendatarios do |t|
      t.string :nombre
      t.string :rif
      t.string :direccion
      t.string :telefono
      t.string :nombre_rl
      t.string :cedula_rl
      t.string :email_rl
      t.string :telefono_rl
      t.references :mall, index: true
      t.timestamps
    end
  end
end
