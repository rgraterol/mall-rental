class CreateCuentaBancaria < ActiveRecord::Migration
  def change
    create_table :cuenta_bancaria do |t|
      t.string :nroCta
      t.string :tipoCuenta
      t.string :beneficiario
      t.string :docIdentidad
      t.references :banco, index: true


      t.timestamps
    end
  end
end
