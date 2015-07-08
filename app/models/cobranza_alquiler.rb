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
        facturas.each do |factura|
          hash_stats = Hash.new
          hash_stats[:cobranza] = cobranza
          hash_stats[:factura] = factura
          hash_stats[:monto_aux] = factura.saldo_deudor
          facturas_array << hash_stats
        end
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

  def self.get_cobranza_x_mes_tienda(tiendas,year,month)
    cobranzas = Array.new
    tiendas.each do |tienda|
      hash_stats = Hash.new
      hash_stats[:cobranza] = CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,month,tienda.id)
      hash_stats[:tienda] = tienda
      cobranzas << hash_stats
    end
    return cobranzas
  end

  def self.saldo_deudor_x_tienda(tienda_id)
    return CobranzaAlquiler.where(tienda_id: tienda_id).sum(:saldo_deudor)
  end

  def self.saldo_deudor_x_mes(tiendas,year,month)
    saldo = 0
    tiendas.each do |tienda|
      saldo += CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,month,tienda.id).sum(:saldo_deudor)
    end
    return saldo
  end

  def self.monto_alquiler_x_mes(tiendas,year,month)
    monto = 0
    tiendas.each do |tienda|
      monto += CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', year,month,tienda.id).sum(:monto_alquiler)
    end
    return monto
  end

end
