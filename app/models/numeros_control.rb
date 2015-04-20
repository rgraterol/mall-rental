class NumerosControl < ActiveRecord::Base
  def self.get_nro_contrato
    old = NumerosControl.last.nro_contrato
    NumerosControl.create!(nro_contrato: old+1)
    return old
  end
end
