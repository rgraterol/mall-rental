module Dynamic
  class DynamicVentaAuditoriaController < ApplicationController
    respond_to :json

    def auditoria
      @year = params[:year]
      @month = params[:month]

      @suma_canon_ventas = 0
      @suma_canon_fijo = 0
      @total_ventas = 0
      @suma_monto_venta_bruto = 0

      @locales = Local.valid_locals(current_user).all

      @tiendas_mall = Array.new
      @locales.each do |local|
        @tienda_locals = Tienda.where("local_id= ? AND abierta= ?", local.id, true).first
        if !@tienda_locals.blank?
          @contrato_alquiler = ContratoAlquiler.where(tienda_id: (@tienda_locals.id))

          if @contrato_alquiler.first.tipo_canon_alquiler.humanize.capitalize != 'exonerado'
            @obj = {
                'tienda' => @tienda_locals,
                'local' => local,
            }
            @tiendas_mall.push(@obj)
          end
        end
      end


      @array_tienda = Array.new
      @tiendas_mall.each do |tienda_mall|

        @local = tienda_mall['local']
        @tienda = tienda_mall['tienda']

        @datos_cobranza = Array.new
        @tienda_nombre = @tienda.nombre
        @tienda_id = @tienda.id
        @actividad_economica = @tienda.actividad_economica.nombre
        @local_n = @local.nro_local
        @contrato_alquiler = ContratoAlquiler.find_by(tienda: @tienda)

        @tipo_canon = @contrato_alquiler.tipo_canon_alquiler.humanize.capitalize
        @tipo_canon_h = @contrato_alquiler.tipo_canon_alquiler
        if @tipo_canon_h == 'fijo_y_variable_venta_neta' || @tipo_canon_h == 'variableVN'
          @campo_suma = :monto_neto
        else
          @campo_suma = :monto_bruto
        end
        @mall = current_user.mall.id

        @calendario = CalendarioNoLaborable.new()
        @cantidad_dias_laborables = @calendario.cantidad_dias_laborables(@month,@year,@mall)

        @venta_mensual = VentaMensual.where('anio = ? AND mes = ? AND tienda_id = ?', @year,@month,@tienda_id)

        if !@venta_mensual.blank?
          @id_mensual = @venta_mensual.first.id
          @suma_ventas_mes = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(@campo_suma)
          @cantidad_ventas_mes = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).count
          @editable_mensual = @venta_mensual.first.editable
          if @tipo_canon_h == 'fijo_y_variable_venta_neta' || @tipo_canon_h == 'variableVN'
            @monto_venta = @venta_mensual.first.monto_neto
          else
            @monto_venta = @venta_mensual.first.monto_bruto
          end
          @monto_venta_bruto = @venta_mensual.first.monto_bruto
          if @venta_mensual.first.monto_bruto.nil?
            @monto_venta_bruto = 0
          end
          @suma_monto_venta_bruto += @monto_venta_bruto
        else
          @suma_ventas_mes = 0
          @cantidad_ventas_mes = 0
          @editable_mensual = true
          @monto_venta = 0
          @monto_venta_bruto = 0
        end


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
            'editable_mensual' => @editable_mensual,
            'monto_venta' => ActionController::Base.helpers.number_to_currency(@monto_venta, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'monto_venta_bruto' =>  ActionController::Base.helpers.number_to_currency(@monto_venta_bruto, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        }

        @array_tienda.push(@obj)
      end

      @total_s = @suma_canon_fijo + @suma_canon_ventas
      @total_t = ActionController::Base.helpers.number_to_currency(@total_s, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @suma_canon_ventas = ActionController::Base.helpers.number_to_currency(@suma_canon_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @suma_canon_fijo = ActionController::Base.helpers.number_to_currency(@suma_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: "")

      render json: [ result: true, cont: @cantidad_dias_laborables, tiendas: @array_tienda, suma_canon_ventas: @suma_canon_ventas, suma_canon_fijo: @suma_canon_fijo, total: @total_t, total_ventas: @total_ventas, tiendas_cont: @contrato_alquiler, mes: @month, total_ventas_bruto: @suma_monto_venta_bruto]
    end
  end
end