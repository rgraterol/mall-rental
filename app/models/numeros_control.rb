# == Schema Information
#
# Table name: numeros_controls
#
#  id           :integer          not null, primary key
#  nro_contrato :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class NumerosControl < ActiveRecord::Base
  def self.get_nro_contrato
    old = NumerosControl.last.nro_contrato
    NumerosControl.create!(nro_contrato: old+1)
    return old
  end
end
