class CobranzaAlquiler < ActiveRecord::Base
  belongs_to :tienda
  has_many :factura_alquilers

  def self.get_num_facturas(tienda_id)
    return CobranzaAlquiler.joins(:factura_alquilers).where(tienda_id: tienda_id).count()
  end

  def self.get_facturas_x_pagar(tienda_id)
    cobranza_alquiler = CobranzaAlquiler.where(tienda_id: tienda_id)
    facturas_array = Array.new

    if !cobranza_alquiler.blank?
      cobranza_alquiler.each do |cobranza|
        facturas = cobranza.factura_alquilers.get_facturas_x_pagar
        facturas_array.push(facturas)
      end
      return facturas_array
    else
      return nil
    end
  end

  def self.get_cobranzas(user)
    tiendas = user.mall.tiendas
    cobranzas = Array.new
    tiendas.each do |tienda|
      cobranzas.push(CobranzaAlquiler.joins(:tienda).where(tienda_id: tienda.id))
    end
    return cobranzas
  end

  def self.get_cobranza_mes_xtienda(mall,year,month)
    cobranzas = Array.new
    tiendas = mall.tiendas
    tiendas.each do |tienda|
      cobranza = CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,month,tienda.id)
      if !cobranza.blank?
        cobranzas.push(cobranza)
      end
    end
    return cobranzas
  end

  def self.get_cobranza_xtienda(tienda,year,month)
      return CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,month,tienda.id)
  end

  def self.saldo_deudor_x_tienda(tienda_id)
    return CobranzaAlquiler.where(tienda_id: tienda_id).sum(:saldo_deudor)
  end

  def self.get_canon_fijo(tienda,anio, mes)
    cobranza = CobranzaAlquiler.find_by('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', anio,mes,tienda.id)
    if !cobranza.nil?
      return cobranza.monto_canon_fijo
    else
      return 0
    end

  end

  def self.get_canon_variable(tienda,anio, mes)
    cobranza = CobranzaAlquiler.find_by('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', anio,mes,tienda.id)
    if !cobranza.nil?
      return cobranza.monto_canon_variable
    else
      return 0
    end

  end

  def self.saldo_deudor_x_mes(mall,year,month)
    saldo = 0
    tiendas = mall.tiendas
    tiendas.each do |tienda|
      saldo += CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,month,tienda.id).sum(:saldo_deudor)
    end
    return saldo
  end

  def self.monto_alquiler_x_mes(mall,year,month)
    monto = 0
    tiendas = mall.tiendas
    tiendas.each do |tienda|
      monto += CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,month,tienda.id).sum(:monto_alquiler)
    end
    return monto
  end

  def self.get_cobranza_xmes(mall,year)
    today = Time.now
    if today.strftime("%Y") == year
      mes_fin = today.strftime("%-m")
    else
      mes_fin = 12
    end
    cobranzas = Array.new

    meses = ['Enero', 'Febrero', 'Marzo', 'Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']

    (1 .. mes_fin.to_i).each do |mes|
      hash_stats = Hash.new
      canon_fijo = 0
      canon_variable = 0
      facturado = 0
      pagado = 0
      pagado_usd = 0
      x_cobrar = 0

      tiendas_mall = mall.tiendas
      tiendas_mall.each do |tienda|

        cobranza = CobranzaAlquiler.find_by('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,mes, tienda.id)

        if !cobranza.blank?
          canon_fijo += cobranza.monto_canon_fijo
          canon_variable += cobranza.monto_canon_variable
          facturado += cobranza.monto_alquiler
          x_cobrar += cobranza.saldo_deudor
          pagado += facturado - x_cobrar
          pagado_usd += pagado.to_f / CambioMoneda.last.cambio_ml_x_usd

        end
      end
      hash_stats[:num_mes] = mes
      hash_stats[:mes] = meses[mes-1]
      hash_stats[:canon_fijo] = ActionController::Base.helpers.number_to_currency(canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:canon_variable] = ActionController::Base.helpers.number_to_currency(canon_variable, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:facturado] = ActionController::Base.helpers.number_to_currency(facturado, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:x_cobrar] = ActionController::Base.helpers.number_to_currency(x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:pagado] = ActionController::Base.helpers.number_to_currency(pagado, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      hash_stats[:pagado_usd] = ActionController::Base.helpers.number_to_currency(pagado_usd, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      cobranzas << hash_stats

    end
    return cobranzas
  end

  def self.get_total_cobranzas_xmes(mall,year)
    tiendas_mall = mall.tiendas
    total_canon_fijo = 0
    total_canon_variable = 0
    total_facturado = 0
    total_pagado = 0
    total_pagado_usd = 0
    total_x_cobrar = 0
    result = false

    tiendas_mall.each do |tienda|
      total_canon_fijo += CobranzaAlquiler.where('anio_alquiler = ? AND tienda_id = ?', year, tienda.id).sum(:monto_canon_fijo)
      total_canon_variable += CobranzaAlquiler.where('anio_alquiler = ? AND tienda_id = ?', year, tienda.id).sum(:monto_canon_variable)
      total_facturado += CobranzaAlquiler.where('anio_alquiler = ? AND tienda_id = ?', year, tienda.id).sum(:monto_alquiler)
      total_x_cobrar += CobranzaAlquiler.where('anio_alquiler = ? AND tienda_id = ?', year, tienda.id).sum(:saldo_deudor)
    end
    total_pagado += total_facturado - total_x_cobrar
    total_pagado_usd += total_pagado.to_f / CambioMoneda.last.cambio_ml_x_usd

    if total_canon_fijo != 0 || total_canon_variable != 0 || total_facturado != 0
      result = true
    end
    hash_totales = Hash.new
    hash_totales[:total_canon_fijo] = ActionController::Base.helpers.number_to_currency(total_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    hash_totales[:total_canon_variable] = ActionController::Base.helpers.number_to_currency(total_canon_variable, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    hash_totales[:total_facturado] = ActionController::Base.helpers.number_to_currency(total_facturado, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    hash_totales[:total_x_cobrar] = ActionController::Base.helpers.number_to_currency(total_x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    hash_totales[:total_pagado] = ActionController::Base.helpers.number_to_currency(total_pagado, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    hash_totales[:total_pagado_usd] = ActionController::Base.helpers.number_to_currency(total_pagado_usd, separator: ',', delimiter: '.', format: "%n %u", unit: "")
    hash_totales[:result] = result
    return hash_totales
  end

end
