# == Schema Information
#
# Table name: venta_mensual
#
#  id                  :integer          not null, primary key
#  anio                :integer
#  mes                 :integer
#  monto               :float
#  monto_notas_credito :float            default(0.0)
#  monto_bruto         :float
#  monto_bruto_USD     :float
#  monto_costo_venta   :float            default(0.0)
#  monto_neto          :float            default(0.0)
#  monto_neto_USD      :float            default(0.0)
#  editable            :boolean          default(TRUE)
#  tienda_id           :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class VentaMensual < ActiveRecord::Base
  belongs_to :tienda
  has_many :venta_diariums
  has_many :documento_ventas

  def self.get_venta_mes_tienda(tienda,year,month)
    return VentaMensual.find_by('anio = ? AND mes = ? AND tienda_id = ?',year,month,tienda)
  end

  def self.suma_venta_mes(tienda,year,month)
    venta_mensual = get_venta_mes_tienda(tienda,year,month)
    if venta_mensual.nil?
      return 0
    else
      return venta_mensual.monto
    end
  end

  def self.suma_notas_credito_mes(tienda,year,month)
    venta_mensual = get_venta_mes_tienda(tienda,year,month)
    if venta_mensual.nil?
      return 0
    else
      return venta_mensual.monto_notas_credito
    end
  end

  def self.suma_costo_venta_mes(tienda,year,month)
    venta_mensual = get_venta_mes_tienda(tienda,year,month)
    if venta_mensual.nil?
      return 0
    else
      return venta_mensual.monto_costo_venta
    end
  end

end
