class NroRecibosCobro < ActiveRecord::Base
  def self.get_numero_recibo
    consulta = NroRecibosCobro.last
    if consulta.nil?
      old = NroRecibosCobro.create!(numero: 1)
    else
      old = NroRecibosCobro.last.numero
      NroRecibosCobro.create!(numero: old+1)
    end
    return old
  end

end
