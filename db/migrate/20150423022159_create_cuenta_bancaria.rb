class CreateCuentaBancaria < ActiveRecord::Migration
  def change
    create_table :cuenta_bancaria do |t|
      t.string :nro_cta
      t.string :tipo_cuenta
      t.string :beneficiario
      t.string :doc_identidad
      t.references :banco, index: true


      t.timestamps
    end
  end
end
