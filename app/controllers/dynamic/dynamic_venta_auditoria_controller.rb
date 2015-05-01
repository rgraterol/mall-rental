module Dynamic
  class DynamicVentaAuditoriaController < ApplicationController
    respond_to :json

    def auditoria
      @year = params[:year]
      @month = params[:month]
      @suma_canon_ventas = 0
      @suma_canon_fijo = 0
      @total_ventas = 0

      @locales = Local.valid_locals(current_user).all

      @tiendas_mall = Array.new
      @locales.each do |local|
        @tienda_locals = Tienda.where("local_id= ? AND abierta= ?", local.id, true).first
        if !@tienda_locals.blank?
          @contrato_alquiler = ContratoAlquiler.where(tienda_id: (@tienda_locals.id))
          #raise @contrato_alquiler.first.inspect
          if @contrato_alquiler.first.tipo_canon_alquiler.humanize.capitalize != 'exonerado'
            @obj = {
                'tienda' => @tienda_locals,
                'local' => local,
            }
            @tiendas_mall.push(@obj)
          end
        end
      end
      #raise @tiendas_mall.inspect

      @array_tienda = Array.new
      @tiendas_mall.each do |tienda_mall|
        #raise tienda_mall.inspect
        @local = tienda_mall['local']
        @tienda = tienda_mall['tienda']

        @datos_cobranza = Array.new
        @tienda_nombre = @tienda.nombre
        @tienda_id = @tienda.id
        @actividad_economica = @tienda.actividad_economica.nombre
        @local_n = @local.nro_local
        @contrato_alquiler = ContratoAlquiler.find_by(tienda: @tienda)

        @tipo_canon = @contrato_alquiler.tipo_canon_alquiler.humanize.capitalize

        @calendario = CalendarioNoLaborable.new()
        @cantidad_dias_laborables = @calendario.cantidad_dias_laborables(@month,@year)

        @suma_ventas_mes = Venta.where('extract(year from fecha) = ? AND extract(month from fecha ) = ? AND tienda_id = ?', @year,@month,@tienda.id).sum(:monto_ml)
        @cantidad_ventas_mes = Venta.where('extract(year from fecha) = ? AND extract(month from fecha ) = ? AND tienda_id = ?', @year,@month,@tienda.id).count

        @canons = @contrato_alquiler.calculate_canon(@contrato_alquiler,@suma_ventas_mes)
        @canon_fijo = @canons['canon_fijo']
        @canon_x_ventas = @canons['canon_x_ventas']
        @total_canon = @canons['canon_alquiler']

        @actualizada = false
        if(@cantidad_dias_laborables == @cantidad_ventas_mes)
          @actualizada = true
        end



        @recibos_cobro = false
        @recibos_cobro_tienda = PagoAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', @year,@month,@tienda.id)
        if !@recibos_cobro_tienda.blank?
          @recibos_cobro = true
        end
        @suma_canon_ventas += @canon_x_ventas
        @suma_canon_fijo += @canon_fijo
        @total_ventas += @suma_ventas_mes
        @obj = {
            'tienda_id' => @tienda_id,
            'tienda' => @tienda_nombre,
            'actividad_economica' => @actividad_economica,
            'local' => @local_n,
            'nivel_ubicacion' => @local.nivel_mall.nombre,
            'tipo_canon' => @tipo_canon,
            'canon_fijo' => ActionController::Base.helpers.number_to_currency(@canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'canon_x_ventas' => ActionController::Base.helpers.number_to_currency(@canon_x_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'ventas_mes' => ActionController::Base.helpers.number_to_currency(@suma_ventas_mes, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_canon' => ActionController::Base.helpers.number_to_currency(@total_canon, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'actualizada' => @actualizada,
            'recibos_cobro' => @recibos_cobro,
            'dias_loborables' => @cantidad_dias_laborables,
            'cantidad_ventas' => @cantidad_ventas_mes,
        }

        @array_tienda.push(@obj)
      end

      @total_s = @suma_canon_fijo + @suma_canon_ventas
      @total_t = ActionController::Base.helpers.number_to_currency(@total_s, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @suma_canon_ventas = ActionController::Base.helpers.number_to_currency(@suma_canon_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @suma_canon_fijo = ActionController::Base.helpers.number_to_currency(@suma_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @total_ventas = ActionController::Base.helpers.number_to_currency(@total_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      render json: [ result: true, cont: @cantidad_dias_laborables, tiendas: @array_tienda, suma_canon_ventas: @suma_canon_ventas, suma_canon_fijo: @suma_canon_fijo, total: @total_t, total_ventas: @total_ventas, tiendas_cont: @contrato_alquiler]
    end
  end
end