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
        @contrato_alquiler = ContratoAlquiler.where(tienda: tienda)
        @tipo_canon = @contrato_alquiler.last.tipo_canon_alquiler

        if @tipo_canon == 'canon_fijo'
          @canon_x_ventas = 0
          @canon_fijo = @contrato_alquiler.last.canon_fijo_ml
        elsif @tipo_canon == 'canon_fijo_y_porcentaje_ventas'
          @canon_x_ventas = (@suma_ventas_mes * @contrato_alquiler.last.porc_canon_ventas)
          @canon_fijo = @contrato_alquiler.last.canon_fijo_ml
        elsif @tipo_canon == 'porcentaje_de_ventas'
          @canon_fijo = 0
          @canon_x_ventas = @suma_ventas_mes * @contrato_alquiler.last.porc_canon_ventas
        end

        @nro_recibo = '001' #falta aumentar el num de recibo
        @fecha_recibo = Date.today
        @anio_alquiler = @year
        @mes_alquiler = @month
        @monto_canon_fijo_ml = @canon_fijo
        @monto_porc_ventas = @canon_x_ventas
        @monto_alquiler = @canon_fijo + @canon_x_ventas
        @monto_alquiler_usd = @monto_alq
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
