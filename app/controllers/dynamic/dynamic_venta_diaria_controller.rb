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
      @venta_mensual = VentaMensual.where('anio = ? AND mes = ? AND tienda_id = ?', @year,@month,@tienda_id)


      for i in 1..@dias_mes
        @fecha = Date.new(@year.to_i,@month.to_i,i)
        @dia_no_lab = CalendarioNoLaborable.find_by('extract(year from fecha) = ? AND extract(month from fecha) = ? AND extract(day from fecha ) = ? AND mall_id = ?', @year,@month,i,@mall_id)
        if @venta_mensual.length > 0 && @dia_no_lab.blank?
          @id_mensual = @venta_mensual.first.id
          @ventas = VentaDiarium.where('fecha = ? AND venta_mensual_id = ?', @fecha,@id_mensual)

          if !@ventas.blank?
            @ventas_dia = @ventas.first
            if @ventas_dia.monto_notas_credito.nil?
              @monto_notas_c = 0
            else
              @monto_notas_c = @ventas_dia.monto_notas_credito
            end

            @venta_bruta = @ventas_dia.monto - @monto_notas_c
            @venta_neta = @venta_bruta - @ventas_dia.monto_costo_venta
            @obj = {
                'id' => @ventas_dia.id,
                'dia' => i,
                'fecha' => @ventas_dia.fecha.strftime("%d/%m/%Y"),
                'monto' =>  ActionController::Base.helpers.number_to_currency(@ventas_dia.monto, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'monto_notas_credito' =>  ActionController::Base.helpers.number_to_currency(@monto_notas_c, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'monto_venta_bruta' =>  ActionController::Base.helpers.number_to_currency(@venta_bruta, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'monto_costo_venta' =>  ActionController::Base.helpers.number_to_currency(@ventas_dia.monto_costo_venta, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'monto_venta_neta' =>  ActionController::Base.helpers.number_to_currency(@venta_neta, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
                'editable' => @ventas_dia.editable,
            }
          elsif !@dia_no_lab.blank?
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
            }
          end
        elsif !@dia_no_lab.blank?
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
          }
        end
        @ventas_mes.push(@obj)
      end
      @dias_no_lab = CalendarioNoLaborable.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND mall_id = ?', @year,@month,@mall_id).count()
      @suma = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?', @year,@month).sum(:monto)
      @cantidad_ventas_mes = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ? AND venta_mensual_id = ?', @year,@month,@id_mensual).count()
      @suma = ActionController::Base.helpers.number_to_currency(@suma, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      render json: [ventas: @ventas_mes, result: true, suma: @suma, tienda_id: @tienda_id, dias_no_lab: @dias_no_lab, cantidad_ventas_mes: @cantidad_ventas_mes, dias_mes: @dias_mes, mes_actual:@mes_actual]
    end

    def guardar_ventas
      @fecha = params[:fecha]
      @valor = params[:valor].sub('.', '')
      @nota_credito = params[:nota_credito].sub('.', '')
      @valor_bruto = @valor.to_f - @nota_credito.to_f
      @valor_usd = @valor_bruto.to_f / CambioMoneda.last.cambio_ml_x_usd
      @id = params[:identificador]
      @opcion = params[:opcion]
      @tienda_id = params[:tienda_id]
      @year = params[:year]
      @month = params[:month]



      @venta_mensual = VentaMensual.where('anio = ? AND mes = ? AND tienda_id = ?', @year,@month,@tienda_id)

      @suma_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?', @year,@month).sum(:monto)
      @suma_notas_credito = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?', @year,@month).sum(:monto_notas_credito)
      @monto_bruto = @suma_venta - @suma_notas_credito
      @monto_bruto_usd = @monto_bruto / CambioMoneda.last.cambio_ml_x_usd

      if @venta_mensual.blank?
        @venta_mensual = VentaMensual.new(anio: @year, mes: @month, monto: @suma_venta, monto_notas_credito: @suma_notas_credito, monto_bruto: @monto_bruto, monto_bruto_USD: @monto_bruto_usd, tienda_id: @tienda_id)
        if @venta_mensual.save
          @id_mensual = @venta_mensual.id
        end
      else
        @id_mensual = @venta_mensual.first.id
      end

      if @opcion == 'new'
        @venta = VentaDiarium.new(fecha: @fecha, monto: @valor, monto_notas_credito: @nota_credito, monto_bruto: @valor_bruto, monto_bruto_usd: @valor_usd,venta_mensual_id: @id_mensual)
        respond_to do |format|
          if @venta.save
            @suma_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?', @year,@month).sum(:monto)
            @suma_notas_credito = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?', @year,@month).sum(:monto_notas_credito)
            @monto_bruto = @suma_venta - @suma_notas_credito
            @monto_bruto_usd = @monto_bruto / CambioMoneda.last.cambio_ml_x_usd

            @venta_mens = VentaMensual.find_by(id: @id_mensual)
            @venta_mens.update(monto: @suma_venta, monto_notas_credito: @suma_notas_credito, monto_bruto: @monto_bruto, monto_bruto_USD: @monto_bruto_usd)
            format.json { render json: [data: @venta, result: true] }
          else
            render json: [data: @venta, result: false]
          end
        end
      else
        @venta = VentaDiarium.find_by(id: params[:identificador])
        respond_to do |format|
          if @venta.update(monto: @valor, monto_notas_credito: @nota_credito, monto_bruto: @valor_bruto, monto_bruto_usd: @valor_usd)
            @suma_venta = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?', @year,@month).sum(:monto)
            @suma_notas_credito = VentaDiarium.where('extract(year from fecha) = ? AND extract(month from fecha) = ?', @year,@month).sum(:monto_notas_credito)
            @monto_bruto = @suma_venta - @suma_notas_credito
            @monto_bruto_usd = @monto_bruto / CambioMoneda.last.cambio_ml_x_usd

            @venta_mens = VentaMensual.find_by(id: @id_mensual)
            @venta_mens.update(monto: @suma_venta, monto_notas_credito: @suma_notas_credito, monto_bruto: @monto_bruto, monto_bruto_USD: @monto_bruto_usd)
            format.json { render json: [data: @venta, result: true] }
          else
            render json: [data: @venta, result: false]
          end
        end
      end
    end
  end
end