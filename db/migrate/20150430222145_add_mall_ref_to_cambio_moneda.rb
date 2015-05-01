class AddMallRefToCambioMoneda < ActiveRecord::Migration
  def change
    add_reference :cambio_monedas, :mall, index: true
  end
end
