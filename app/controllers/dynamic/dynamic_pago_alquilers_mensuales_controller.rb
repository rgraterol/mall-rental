module Dynamic
  class DynamicPagoAlquilersMensualesController < ApplicationController
    respond_to :json
    def pagos
      @year = params[:year]
      @mall = current_user.mall
      @suma_cobranza = 0
      @suma_pagado_canon_fijo = 0
      @suma_pagado_x_ventas = 0
      @suma_total_pagado = 0
      @suma_total_pagado_usd = 0
      @suma_monto_x_cobrar = 0
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

      @pagos_mes = Array.new

      @tiendas_mall = Mall.find(current_user.mall).tiendas

      for i in 1..(@mes_fin.to_i)
        @k = i.to_s

        @cobranza = 0
        @pagado_canon_fijo = 0
        @pagado_x_ventas = 0
        @total_pagado_ml = 0
        @total_pagado_usd = 0
        @monto_x_cobrar = 0
        @suma_total_pagado_mes = 0

        @tiendas_mall.each do |tienda|
          @pagos_alquiler = PagoAlquiler.find_by('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?',@year,@k,tienda.id)

          if !(@pagos_alquiler.blank?)
              @cobranza += @pagos_alquiler.monto_alquiler_ml
              if @pagos_alquiler.pagado
                @total_pagado_ml += @pagos_alquiler.monto_alquiler_ml
                @total_pagado_usd += @pagos_alquiler.monto_alquiler_usd
                @pagado_canon_fijo += @pagos_alquiler.monto_canon_fijo_ml
                @pagado_x_ventas += @pagos_alquiler.monto_porc_ventas_ml
              else
                @monto_x_cobrar += (@cobranza - @total_pagado_ml)
              end
          end
        end
        @total_pagado = @pagado_canon_fijo + @pagado_x_ventas
        @suma_cobranza += @cobranza
        @suma_total_pagado += @total_pagado
        @suma_total_pagado_usd += @total_pagado_usd
        @suma_pagado_canon_fijo += @pagado_canon_fijo
        @suma_pagado_x_ventas += @pagado_x_ventas
        @suma_monto_x_cobrar += @monto_x_cobrar
        @obj = {
            'total_cobranza' => ActionController::Base.helpers.number_to_currency(@cobranza, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'pagado_canon_fijo' => ActionController::Base.helpers.number_to_currency(@pagado_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'pagado_x_ventas' => ActionController::Base.helpers.number_to_currency(@pagado_x_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_pagado' => ActionController::Base.helpers.number_to_currency(@total_pagado, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_pagado_usd' => ActionController::Base.helpers.number_to_currency(@total_pagado_usd, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'monto_cobrar' => ActionController::Base.helpers.number_to_currency(@monto_x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'mes' => @k
        }

        @pagos_mes.push(@obj)
      end

      @totales = {
        'suma_cobranza' => ActionController::Base.helpers.number_to_currency(@suma_cobranza, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_total_pagado' => ActionController::Base.helpers.number_to_currency(@suma_total_pagado, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_total_pagado_usd' => ActionController::Base.helpers.number_to_currency(@suma_total_pagado_usd, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_pagado_canon_fijo' => ActionController::Base.helpers.number_to_currency(@suma_pagado_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_pagado_x_ventas' => ActionController::Base.helpers.number_to_currency(@suma_pagado_x_ventas, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_monto_x_cobrar' => ActionController::Base.helpers.number_to_currency(@suma_monto_x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      }

      render json: [pagos: @pagos_mes, totales: @totales, mes_actual: @mes_fin]
    end
  end
end