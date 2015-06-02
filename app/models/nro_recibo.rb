# == Schema Information
#
# Table name: nro_recibos
#
#  id         :integer          not null, primary key
#  numero     :integer
#  created_at :datetime
#  updated_at :datetime
#

class NroRecibo < ActiveRecord::Base
  def self.get_numero_recibo
    consulta = NroRecibo.last
    if consulta.nil?
      old = NroRecibo.create!(numero: 1)
    else
      old = NroRecibo.last.numero
      NroRecibo.create!(numero: old+1)
    end
    return old
  end

end
