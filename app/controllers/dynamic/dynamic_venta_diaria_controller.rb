module Dynamic
  class DynamicVentaDiariaController < ApplicationController
    respond_to :json
    def venta
      @year = params[:year]
      @month = params[:month]

      @tienda_id = params[:tienda_id]
      @tienda = Tienda.find_by(id: @tienda_id)
      @mall_id = @tienda.mall.id

      @today = Time.now
      if (@month == @today.strftime("%-m") && @year == @today.strftime("%Y"))
        @dias_mes =  @today.strftime("%d").to_i
        @mes_actual = true
      else
        @dias_mes = Time.days_in_month(@month.to_i, @year.to_i)
        @mes_actual = false
      end

      @ventas_mes = Array.new
      @venta_mensual = VentaMensual.find_by('anio = ? AND mes = ? AND tienda_id = ?', @year,@month,@tienda_id)


      for i in 1..@dias_mes
        @fecha = Date.new(@year.to_i,@month.to_i,i)
        @dia_no_lab = CalendarioNoLaborable.find_by('extract(year from fecha) = ? AND extract(month from fecha) = ? AND extract(day from fecha ) = ? AND mall_id = ?', @year,@month,i,@mall_id)

        if !@venta_mensual.blank?
          @id_mensual = @venta_mensual.id
          @ventas = VentaDiarium.where('fecha = ? AND venta_mensual_id = ?', @fecha,@id_mensual)
          if !@ventas.blank?
            @ventas_dia = @ventas.first
            if @ventas_dia.monto_notas_credito.nil?
              @monto_notas_c = 0
            else
              @monto_notas_c = @ventas_dia.monto_notas_credito
            end

            @venta_bruta = @ventas_dia.monto - @monto_notas_c
            if @ventas_dia.monto_costo_venta.nil?
              @ventas_dia.monto_costo_venta = 0
            end
            @venta_neta = @venta_bruta - @ventas_dia.monto_costo_venta
            @obj = {
                'id' => @ventas_dia.id,
                'dia' => i,
                'fecha' => @ventas_dia.fecha.strftime("%d/%m/%Y"),
                'monto' =>  @ventas_dia.monto,
                'monto_notas_credito' =>  @monto_notas_c,
                'monto_venta_bruta' =>  @venta_bruta,
                'monto_costo_venta' => @ventas_dia.monto_costo_venta,
                'monto_venta_neta' => @venta_neta,
                'editable' => @ventas_dia.editable,
                'no_laborable' => false,
            }
          else
              if !@dia_no_lab.blank?
                @obj = {
                    'id' => '-1',
                    'dia' => i,
                    'fecha' => @fecha.strftime("%d/%m/%Y"),
                    'monto' => 'Dia No Laborable: '+@dia_no_lab.motivo,
                    'monto_notas_credito' => '',
                    'monto_venta_bruta'  => '',
                    'monto_costo_venta'  => '',
                    'monto_venta_neta'  => '',
                    'editable' => false,
                    'no_laborable' => true,
                }
              else
                @obj = {
                    'id' => '-1',
                    'dia' => i,
                    'fecha' => @fecha.strftime("%d/%m/%Y"),
                    'monto' => '',
                    'monto_notas_credito' => '',
                    'monto_venta_bruta'  => '',
                    'monto_costo_venta'  => '',
                    'monto_venta_neta'  => '',
                    'editable' => true,
                    'no_laborable' => false,
                }
              end
          end
        else
          if !@dia_no_lab.blank?
            @obj = {
                'id' => '-1',
                'dia' => i,
                'fecha' => @fecha.strftime("%d/%m/%Y"),
                'monto' => 'Dia No Laborable: '+@dia_no_lab.motivo,
                'monto_notas_credito' => '',
                'monto_venta_bruta'  => '',
                'monto_costo_venta'  => '',
                'monto_venta_neta'  => '',
                'editable' => false,
                'no_laborable' => true,
            }
          else
            @obj = {
                'id' => '-1',
                'dia' => i,
                'fecha' => @fecha.strftime("%d/%m/%Y"),
                'monto' => '',
                'monto_notas_credito' => '',
                'monto_venta_bruta'  => '',
                'monto_costo_venta'  => '',
                'monto_venta_neta'  => '',
                'editable' => true,
                'no_laborable' => false,
            }
          end
        end
        @ventas_mes.push(@obj)
      end


      @dias_no_lab = CalendarioNoLaborable.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND mall_id = ?', @year,@month,@mall_id).count()
      @suma = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?   AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(:monto)
      @cantidad_ventas_mes = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).count()

      render json: [ventas: @ventas_mes, result: true, suma: @suma, tienda_id: @tienda_id, dias_no_lab: @dias_no_lab, cantidad_ventas_mes: @cantidad_ventas_mes, dias_mes: @dias_mes, mes_actual:@mes_actual]
    end

    def guardar_ventas
      @fecha = params[:fecha]
      @valor = params[:valor]

      if params[:nota_credito].nil?
        params[:nota_credito] = 0
      end
      if params[:costo_venta].nil?
        params[:costo_venta] = 0
      end
      @nota_credito = params[:nota_credito]
      @costo_venta = params[:costo_venta]
      @valor_bruto = @valor.to_f - @nota_credito.to_f
      @venta_neta = @valor_bruto - @costo_venta.to_f
      @valor_usd = @valor_bruto.to_f / CambioMoneda.last.cambio_ml_x_usd
      @venta_neta_usd = @venta_neta.to_f / CambioMoneda.last.cambio_ml_x_usd
      @id = params[:identificador]
      @opcion = params[:opcion]
      @tienda_id = params[:tienda_id]
      @year = params[:year]
      @month = params[:month]


      @venta_mensual = VentaMensual.where('anio = ? AND mes = ? AND tienda_id = ?', @year,@month,@tienda_id)
      @suma_venta, @suma_notas_credito, @monto_bruto, @monto_bruto_usd, @suma_costo_venta, @suma_venta_neta, @suma_neto_usd = 0

      if @venta_mensual.blank?
        @venta_mensual = VentaMensual.new(anio: @year, mes: @month, monto: @suma_venta, monto_notas_credito: @suma_notas_credito, monto_bruto: @monto_bruto, monto_bruto_USD: @monto_bruto_usd, monto_costo_venta: @suma_costo_venta, monto_neto: @suma_venta_neta, monto_neto_USD: @suma_neto_usd, tienda_id: @tienda_id)
        if @venta_mensual.save
          @id_mensual = @venta_mensual.id
        end
      else
        @id_mensual = @venta_mensual.first.id
        @suma_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month, @id_mensual).sum(:monto)
        @suma_notas_credito = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?  AND venta_mensual_id = ?', @year,@month, @id_mensual).sum(:monto_notas_credito)
        @suma_costo_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month, @id_mensual).sum(:monto_costo_venta)
        @monto_bruto = @suma_venta - @suma_notas_credito
        @monto_bruto_usd = @monto_bruto / CambioMoneda.last.cambio_ml_x_usd
        @suma_venta_neta = @monto_bruto - @suma_costo_venta
        @suma_neto_usd = @suma_venta_neta / CambioMoneda.last.cambio_ml_x_usd
      end

      if @opcion == 'new'
        @venta = VentaDiarium.new(fecha: @fecha, monto: @valor, monto_notas_credito: @nota_credito, monto_bruto: @valor_bruto, monto_bruto_usd: @valor_usd, monto_costo_venta: @costo_venta, monto_neto: @venta_neta, monto_neto_usd: @venta_neta_usd, venta_mensual_id: @id_mensual)
        respond_to do |format|
          if @venta.save
            @suma_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(:monto)
            @suma_notas_credito = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(:monto_notas_credito)
            @suma_costo_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(:monto_costo_venta)
            @monto_bruto = @suma_venta - @suma_notas_credito
            @monto_bruto_usd = @monto_bruto / CambioMoneda.last.cambio_ml_x_usd
            @suma_venta_neta = @monto_bruto - @suma_costo_venta
            @suma_neto_usd = @suma_venta_neta / CambioMoneda.last.cambio_ml_x_usd

            @venta_mens = VentaMensual.find_by(id: @id_mensual)
            @venta_mens.update(monto: @suma_venta, monto_notas_credito: @suma_notas_credito, monto_bruto: @monto_bruto, monto_bruto_USD: @monto_bruto_usd, monto_costo_venta: @suma_costo_venta, monto_neto: @suma_venta_neta, monto_neto_USD: @suma_neto_usd)
            format.json { render json: [data: @venta, result: true] }
          else
            render json: [data: @venta, result: false]
          end
        end
      else
        @venta = VentaDiarium.find_by(id: params[:identificador])
        respond_to do |format|
          if @venta.update( monto: @valor, monto_notas_credito: @nota_credito, monto_bruto: @valor_bruto, monto_bruto_usd: @valor_usd, monto_costo_venta: @costo_venta, monto_neto: @venta_neta, monto_neto_usd: @venta_neta_usd)
            @suma_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(:monto)
            @suma_notas_credito = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(:monto_notas_credito)
            @suma_costo_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).sum(:monto_costo_venta)
            @monto_bruto = @suma_venta - @suma_notas_credito
            @monto_bruto_usd = @monto_bruto / CambioMoneda.last.cambio_ml_x_usd
            @suma_venta_neta = @monto_bruto - @suma_costo_venta
            @suma_neto_usd = @suma_venta_neta / CambioMoneda.last.cambio_ml_x_usd

            @venta_mens = VentaMensual.find_by(id: @id_mensual)
            @venta_mens.update(monto: @suma_venta, monto_notas_credito: @suma_notas_credito, monto_bruto: @monto_bruto, monto_bruto_USD: @monto_bruto_usd, monto_costo_venta: @suma_costo_venta, monto_neto: @suma_venta_neta, monto_neto_USD: @suma_neto_usd)
            format.json { render json: [data: @venta, result: true] }
          else
            render json: [data: @venta, result: false]
          end
        end
      end
    end


    def cerrar_ventas_mes
      @year = params[:year]
      @month = params[:month]
      @tienda_id = params[:tienda]

      @venta_mensual = VentaMensual.find_by('anio = ? AND mes = ? AND tienda_id = ?', @year,@month,@tienda_id)
      @id_mensual = @venta_mensual.id
      if @venta_mensual.editable
        @venta_mensual.update(editable: false)

        @venta_diaria = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual)
        if !@venta_diaria.blank?
          @venta_diaria.each do |venta|
            @vent = venta.update(editable: false)
            @result = 1
          end
        end
      else
        @result = 2
      end

      render json: [data: @vent, result: @result]
    end

  end
end