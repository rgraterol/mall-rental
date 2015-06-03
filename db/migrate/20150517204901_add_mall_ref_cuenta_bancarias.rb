class AddMallRefCuentaBancarias < ActiveRecord::Migration
  def change
    add_reference :cuenta_bancaria, :mall, index: true
  end
end
