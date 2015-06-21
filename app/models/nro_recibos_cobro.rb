class NroRecibosCobro < ActiveRecord::Base
  def self.get_numero_recibo
    consulta = NroReciboCobro.last
    if consulta.nil?
      old = NroReciboCobro.create!(numero: 1)
    else
      old = NroReciboCobro.last.numero
      NroReciboCobro.create!(numero: old+1)
    end
    return old
  end

end
