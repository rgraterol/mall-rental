# == Schema Information
#
# Table name: calendario_no_laborables
#
#  id         :integer          not null, primary key
#  fecha      :date
#  motivo     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CalendarioNoLaborable < ActiveRecord::Base
  validates :motivo, presence: true
  validates :fecha, presence: true, uniqueness: true
  has_many :malls

  def cantidad_dias_laborables(mes,anio)
    @mes = Time.days_in_month(mes.to_i, anio.to_i)

    @today = Time.now
    if (mes == @today.strftime("%-m") && anio == @today.strftime("%Y"))
      @mes =  @today.strftime("%d").to_i
    else
      @mes = Time.days_in_month(mes.to_i, anio.to_i)
    end
    @hoy = @today.strftime("%d").to_i
    @dias = CalendarioNoLaborable.where('extract(year from fecha) = ? AND extract(month from fecha ) = ? AND extract(day from fecha )<= ?', anio,mes,@hoy).count
    return (@mes-@dias)
  end
end
