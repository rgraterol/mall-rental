module Dynamic
  class DynamicVentaDiariaController < ApplicationController
    respond_to :json
    def venta
      @year = params[:year]
      @month = params[:month]
      @tienda_id = params[:tienda_id]

      @tienda = Tienda.find_by(id: @tienda_id)

      @today = Time.now
      if (@month == @today.strftime("%-m") && @year == @today.strftime("%Y"))
        @dias_mes =  @today.strftime("%d").to_i
      else
        @dias_mes = Time.days_in_month(@month.to_i, @year.to_i)
      end

      @ventas_mes = Array.new

      for i in 1..@dias_mes
        @fecha = Date.new(@year.to_i,@month.to_i,i)
        @ventas_dia = Venta.where(fecha: @fecha).where(tienda_id: @tienda_id)

        if @ventas_dia.length > 0
          @obj = {
              'id' => @ventas_dia.first.id,
              'fecha' => @ventas_dia.first.fecha.strftime("%d/%m/%Y"),
              'monto' =>  ActionController::Base.helpers.number_to_currency(@ventas_dia.first.monto_ml, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
              'editable' => @ventas_dia.first.editable,
          }
        else
          @obj = {
              'id' => '-1',
              'fecha' => @fecha.strftime("%d/%m/%Y"),
              'monto' => '',
              'editable' => true,
          }
        end
        @ventas_mes.push(@obj)
      end
      @suma = Venta.where('extract(year from fecha) = ? AND extract(month from fecha ) = ? AND tienda_id = ?', @year,@month,@tienda_id).sum(:monto_ml)
      @suma = ActionController::Base.helpers.number_to_currency(@suma, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      render json: [ventas: @ventas_mes, result: true, suma: @suma, tienda_id: @tienda_id]
    end
    def guardar_ventas
      @fecha = params[:codigo]
      @valor = params[:valor]
      @id = params[:id]
      @tienda_id = params[:tienda_id]

      if @id == '-1'
        @venta = Venta.new(fecha: @fecha, monto_ml: @valor,monto_usd: @valor,tienda_id: @tienda_id)
        respond_to do |format|
          if @venta.save
            #format.html { render 'layouts/flash_message', message: 'Venta guardada satisfactoriamente.' }
            format.json { render json: [data: @venta, result: true] }
          else
            render json: [data: @tienda, result: false]
          end
        end
      else
        @venta = Venta.find_by(id: params[:id])
        respond_to do |format|
          if @venta.update(monto_ml: @valor,monto_usd: @valor)
            #format.html { render 'layouts/flash_message', message: 'Venta guardada satisfactoriamente.' }
            format.json { render json: [data: @venta, result: true] }
          else
            render json: [data: @venta, result: false]
          end
        end
      end
    end
  end
end