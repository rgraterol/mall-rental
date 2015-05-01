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

        @nro_recibo = '001' #falta aumentar el num de recibo
        @fecha_recibo = Date.today
        @anio_alquiler = @year
        @mes_alquiler = @month

        @canons = @contrato_alquiler.calculate_canon(@contrato_a,@suma_ventas_mes)
        @monto_canon_fijo_ml = @canons['canon_fijo']
        @monto_porc_ventas = @canons['canon_x_ventas']
        @monto_alquiler = @canons['canon_alquiler']
        @monto_alquiler_usd = @monto_alquiler
        @pagado = false

        @pago = PagoAlquiler.new(nro_recibo: @nro_recibo, fecha_recibo_cobro: @fecha_recibo,
                           anio_alquiler: @anio_alquiler, mes_alquiler: @mes_alquiler,
                           monto_canon_fijo_ml: @monto_canon_fijo_ml, monto_porc_ventas_ml: @monto_porc_ventas,
                           monto_alquiler_ml: @monto_alquiler, monto_alquiler_usd: @monto_alquiler, pagado: @pagado,
                           tienda_id: tienda)
        if @pago.save
          @result = true
        end

        @ventas = Venta.where('extract(year from fecha) = ? AND extract(month from fecha ) = ? AND tienda_id = ?', @year,@month,tienda)
        @ventas.each do |venta|
          if venta.update(editable: false)
            @result = true
          end
        end

        @ventas_tiendas.push(@result)
      end
      render json: [data: @ventas, result: @result, tiendas: @tiendas, ventas_tiendas: @ventas_tiendas]
    end
  end
end
