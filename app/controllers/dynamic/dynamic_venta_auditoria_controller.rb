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
        @tienda_locals = Tienda.where(local_id: local.id)
        @obj = {
            'tienda' => @tienda_locals,
            'local' => local
        }
        @tiendas_mall.push(@obj)
      end

      @array_tienda = Array.new
      @tiendas_mall.each do |tienda_mall|
        @local = tienda_mall['local']
        tienda_mall['tienda'].each do |tienda|

          @datos_cobranza = Array.new
          @tienda = tienda.nombre
          @tienda_id = tienda.id
          @actividad_economica = tienda.actividad_economica.nombre
          @local_n = @local.nro_local
          @contrato_alquiler = ContratoAlquiler.where(tienda: tienda)
          @tipo_canon = @contrato_alquiler.last.tipo_canon_alquiler

          @calendario = CalendarioNoLaborable.new()
          @cantidad_dias_laborables = @calendario.cantidad_dias_laborables(@month,@year)

          @suma_ventas_mes = Venta.where('extract(year from fecha) = ? AND extract(month from fecha ) = ? AND tienda_id = ?', @year,@month,tienda.id).sum(:monto_ml)
          @cantidad_ventas_mes = Venta.where('extract(year from fecha) = ? AND extract(month from fecha ) = ? AND tienda_id = ?', @year,@month,tienda.id).count

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

          @total_canon = (@canon_fijo + @canon_x_ventas)
          @actualizada = false
          if(@cantidad_dias_laborables == @cantidad_ventas_mes)
            @actualizada = true
          end

          @recibos_cobro = false
          @recibos_cobro_tienda = PagoAlquiler.where('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?', @year,@month,tienda.id)
          if !@recibos_cobro_tienda.blank?
            @recibos_cobro = true
          end
          @obj = {
              'tienda_id' => @tienda_id,
              'tienda' => @tienda,
              'actividad_economica' => @actividad_economica,
              'local' => @local_n,
              'nivel_ubicacion' => @local.nivel_mall.nombre,
              'tipo_canon' => @tipo_canon,
              'canon_fijo' => @canon_fijo,
              'canon_x_ventas' => @canon_x_ventas,
              'ventas_mes' => @suma_ventas_mes,
              'total_canon' => @total_canon,
              'actualizada' => @actualizada,
              'recibos_cobro' => @recibos_cobro,
          }

          @suma_canon_ventas += @canon_x_ventas
          @suma_canon_fijo += @canon_fijo
          @total_ventas += @suma_ventas_mes

          @array_tienda.push(@obj)
        end
      end
      @total_s = @suma_canon_fijo + @suma_canon_ventas
      render json: [ result: true, cont: @cantidad_dias_laborables, tiendas: @array_tienda, suma_canon_ventas: @suma_canon_ventas, suma_canon_fijo: @suma_canon_fijo, total: @total_s, total_ventas: @total_ventas]
    end
  end
end