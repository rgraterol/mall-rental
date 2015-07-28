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

  def self.get_ventas_mes_xtienda(mall,year,month)
    ventas_mes = Array.new
    mall.tiendas do |tienda|
      venta_mes = VentaMensual.where('anio = ? AND mes = ? AND tienda_id = ?',year,month,tienda)
      ventas_mes.push(venta_mes)
    end
    return ventas_mes
  end

  def self.suma_venta_mes(tienda,year,month)
    venta_mensual = get_venta_mes_tienda(tienda,year,month)
    if venta_mensual.nil?
      return 0
    else
      return venta_mensual.monto
    end
  end

  def self.monto_bruto_mes(tienda,year,month)
    venta_mensual = get_venta_mes_tienda(tienda,year,month)
    if venta_mensual.nil?
      return 0
    else
      return venta_mensual.monto_bruto
    end
  end

  def self.monto_neto_mes(tienda,year,month)
    venta_mensual = get_venta_mes_tienda(tienda,year,month)
    if venta_mensual.nil?
      return 0
    else
      return venta_mensual.monto_neto
    end
  end

  def self.get_is_editable(tienda,anio,mes)
    venta_mensual = get_venta_mes_tienda(tienda,anio,mes)
    if venta_mensual.nil?
      return true
    else
      return venta_mensual.editable
    end
  end


  def self.suma_monto_bruto(mall,year)
    suma = 0
    mall.tiendas.each do |tienda|
      suma += VentaMensual.where("tienda_id = ? AND anio = ?", tienda, year).sum(:monto_bruto)
      suma = 0 if suma.nil?
    end
    return suma
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

  def self.get_ventas_xmes(mall,year)
    today = Time.now
    if today.strftime("%Y") == year
      mes_fin = today.strftime("%-m")
    else
      mes_fin = 12
    end
    ventas = Array.new

    meses = ['Enero', 'Febrero', 'Marzo', 'Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']

    (1 .. mes_fin.to_i).each do |mes|
      hash_stats = Hash.new
      suma_ventas = 0
      canon_fijo = 0
      canon_variable = 0
      canon = 0

      tiendas_mall = mall.tiendas
      tiendas_mall.each do |tienda|
        venta = VentaMensual.find_by('anio = ? AND mes = ? AND tienda_id = ?', year,mes, tienda.id)
        cobranza = CobranzaAlquiler.find_by('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,mes, tienda.id)

        if !venta.blank?
          suma_ventas += venta.monto_bruto.to_f
        end
        if !cobranza.blank?
          canon_fijo += cobranza.monto_canon_fijo
          canon_variable += cobranza.monto_canon_variable
          canon += cobranza.monto_alquiler
        end
      end
      hash_stats[:num_mes] = mes
      hash_stats[:mes] = meses[mes-1]
      hash_stats[:mes_fin] = mes_fin.to_i - 1
      hash_stats[:suma_venta] = ActionController::Base.helpers.number_to_currency(suma_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:canon_fijo] = ActionController::Base.helpers.number_to_currency(canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:canon_variable] = ActionController::Base.helpers.number_to_currency(canon_variable, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:canon] = ActionController::Base.helpers.number_to_currency(canon, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      ventas << hash_stats

    end
    return ventas
  end

end
