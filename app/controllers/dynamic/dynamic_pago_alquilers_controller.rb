module Dynamic
  class DynamicPagoAlquilersController < ApplicationController
    respond_to :json

    def recibos_cobro
      @tiendas = params[:tiendas]
      @year = params[:year]
      @month = params[:month]
      @tiendas_id = Array.new
      @ventas_tiendas = Array.new
      @tiendas.each do |tienda|
        @tiend = Tienda.where(id: tienda)
        @contrato_alquiler = ContratoAlquiler.find_by(tienda: tienda)
        @contrato_a = ContratoAlquiler.find_by(tienda: tienda)
        @tipo_canon = @contrato_alquiler.tipo_canon_alquiler.humanize.capitalize


        @nro_recibo = NroRecibo.get_numero_recibo.to_s
        @nro_recibo = @nro_recibo.to_s.rjust(4, '0')

        @fecha_recibo = Date.today
        @anio_alquiler = @year
        @mes_alquiler = @month

        @canons = @contrato_alquiler.calculate_canon(@contrato_a,@suma_ventas_mes)
        @monto_canon_fijo_ml = @canons['canon_fijo']
        @monto_porc_ventas = @canons['canon_x_ventas']
        @monto_alquiler = @canons['canon_alquiler']
        @monto_alquiler_usd = @monto_alquiler/CambioMoneda.last.cambio_ml_x_usd
        @pagado = false

        @pago = PagoAlquiler.new(nro_recibo: @nro_recibo, fecha_recibo_cobro: @fecha_recibo,
                           anio_alquiler: @anio_alquiler, mes_alquiler: @mes_alquiler,
                           monto_canon_fijo_ml: @monto_canon_fijo_ml, monto_porc_ventas_ml: @monto_porc_ventas,
                           monto_alquiler_ml: @monto_alquiler, monto_alquiler_usd: @monto_alquiler_usd, pagado: @pagado,
                           tienda_id: tienda)
        if @pago.save
          @result = true
        end

        @ventas = VentaMensual.where('anio = ? AND mes = ? AND tienda_id = ?', @year,@month,@tienda_id)
        @ventas.each do |venta|
          if !venta.editable
            @result = true
          end
        end

        @ventas_tiendas.push(@result)
      end
      render json: [data: @ventas, result: @result, tiendas: @tiendas, ventas_tiendas: @ventas_tiendas]
    end

    def actualizar_pagos
      @year = params[:year]
      @month = params[:month]
      @suma_x_cobrar = 0
      @suma_monto_alquiler = 0
      @suma_monto_pagado = 0
      @tiendas = current_user.mall.tiendas
      @cobranza_alquilers = Array.new
      @tiendas.each do |tienda|
       # @pago_alq = PagoAlquiler.find_by('extract(year from fecha_recibo_cobro) = ? AND extract(month from fecha_recibo_cobro) = ? AND tienda_id = ?', @year,@month,tienda.id)
        @cobranza_alq = CobranzaAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', @year,@month,tienda.id)

        if !@cobranza_alq.blank?
          @cobranza_alq.each do |cobranza|
            @monto_alquiler = cobranza.monto_alquiler
            @suma_monto_alquiler += @monto_alquiler

            @saldo_deudor = cobranza.saldo_deudor
            @saldo_abonado = @monto_alquiler - @saldo_deudor

            @suma_x_cobrar +=  @saldo_deudor
            @suma_monto_pagado += @saldo_abonado

            @obj = {
                'tienda' => tienda.nombre,
                'nro_recibo' => cobranza.nro_recibo,
                'fecha' => cobranza.fecha_recibo_cobro.strftime("%d/%m/%Y"),
                'monto_pagado' => ActionController::Base.helpers.number_to_currency(@saldo_abonado, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'monto_alquiler' => ActionController::Base.helpers.number_to_currency(@monto_alquiler, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'saldo_deudor' => ActionController::Base.helpers.number_to_currency(@saldo_deudor, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'monto_pago' => @saldo_abonado,
                'monto_x_cobrar' => @saldo_deudor,
            }
            @cobranza_alquilers.push(@obj)
          end
        end
      end


      if @cobranza_alquilers.blank?
        @cont = 0
      else
        @cont = @cobranza_alquilers.count
      end

      @suma_alquiler = ActionController::Base.helpers.number_to_currency(@suma_monto_alquiler, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @suma_x_cobrar = ActionController::Base.helpers.number_to_currency(@suma_x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @suma_monto_pagado = ActionController::Base.helpers.number_to_currency(@suma_monto_pagado, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      render json: [cobranza_alquilers: @cobranza_alquilers, result: true, suma: @suma_alquiler, cont: @cont, suma_x_cobrar: @suma_x_cobrar, suma_monto_pagado: @suma_monto_pagado]
    end

    def facturas_tiendas
      @tienda_id = params[:tienda_id]
      render json: [id: @tienda_id]
    end
  end
end
