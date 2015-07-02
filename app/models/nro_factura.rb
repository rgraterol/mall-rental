class NroFactura < ActiveRecord::Base
  def self.get_numero_factura
    consulta = NroFactura.last
    if consulta.nil?
      old = NroFactura.create!(numero: 1)
    else
      old = NroFactura.last.numero
      NroFactura.create!(numero: old+1)
    end
    return old
  end
end
