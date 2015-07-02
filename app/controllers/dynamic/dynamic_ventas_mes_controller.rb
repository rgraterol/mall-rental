module Dynamic
  class DynamicVentasMesController < ApplicationController
    respond_to :json
    def ventas
      @year = params[:year]
      @mall = current_user.mall
      @suma_total = 0
      @total_canon_fijo = 0
      @total_canon_x_ventas = 0
      @today = Time.now
      if (@month == @today.strftime("%-m") && @year == @today.strftime("%Y"))
        @dias_mes =  @today.strftime("%d").to_i
      else
        @dias_mes = Time.days_in_month(@month.to_i, @year.to_i)
      end

      if @today.strftime("%Y") == @year
        @mes_fin = @today.strftime("%-m")
      else
        @mes_fin = 12
      end

      @ventas_mes = Array.new
      @tiendas_mall = Mall.find(current_user.mall).tiendas
      for i in 1..@mes_fin.to_i
        @k = i.to_s
        @suma = 0
        @canon_fijo = 0
        @canon_x_ventas = 0
        @total_mes_canon = 0
        @tiendas_mall.each do |tienda|

          @ventas = tienda.venta_mensuals.find_by('anio = ? AND mes = ?', @year, @k)

          if !@ventas.blank?
            @venta_bruto = @ventas.monto_bruto
            @suma += @venta_bruto
          else
            @venta_bruto = 0
          end
          @contratos = tienda.contrato_alquilers.where(:estado_contrato => true)
          @canon_fijo = 0
          @canon_x_ventas = 0

          if @contratos.count > 0
            if !@contratos.first.canon_fijo_ml.nil?
              @canon_fijo += @contratos.first.canon_fijo_ml
            else
              @canon_fijo = 0
            end

            if !@contratos.first.porc_canon_ventas.nil?
              @canon_x_ventas += (@contratos.first.porc_canon_ventas * @venta_bruto)
            end
          end


          @total_mes_canon = @canon_fijo + @canon_x_ventas

          @obj = {
              'venta_mensual' => ActionController::Base.helpers.number_to_currency(@suma, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
              'canon_fijo' => ActionController::Base.helpers.number_to_currency(@canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
              'canon_x_ventas' => ActionController::Base.helpers.number_to_currency(@canon_x_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
              'total_mes_canon' => ActionController::Base.helpers.number_to_currency(@total_mes_canon, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
          }
        end

        @ventas_mes.push(@obj)
        @suma_total += @suma
        @total_canon_x_ventas += @canon_x_ventas
        @total_canon_fijo += @canon_fijo
        @suma = ActionController::Base.helpers.number_to_currency(@suma, separator: ',', delimiter: '.', format: "%n %u", unit: "")
        @total_canons = @total_canon_fijo + @total_canon_x_ventas
      end
      @total_canon_x_ventas = ActionController::Base.helpers.number_to_currency(@total_canon_x_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @total_canon_fijo = ActionController::Base.helpers.number_to_currency(@total_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @suma_total = ActionController::Base.helpers.number_to_currency(@suma_total, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      @total_canons = ActionController::Base.helpers.number_to_currency(@total_canons, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      render json: [ventas: @ventas_mes, result: true, suma_total: @suma_total, total_canon_x_ventas: @total_canon_x_ventas, total_canon_fijo: @total_canon_fijo, total_mes_canon: @total_mes_canon, total_canons: @total_canons, mes_actual: @mes_fin]
    end
  end
end