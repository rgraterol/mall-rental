module Dynamic
  class DynamicPagoAlquilersMensualesController < ApplicationController
    respond_to :json
    def pagos
      @year = params[:year]
      @mall = current_user.mall
      @suma_pagado_canon_fijo = 0
      @suma_pagado_canon_variable = 0
      @suma_total_pagado = 0
      @suma_total_pagado_usd = 0
      @suma_monto_x_cobrar = 0
      @suma_total_facturado = 0

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

      @cobranza_mes = Array.new

      @tiendas_mall = Mall.find(current_user.mall).tiendas
      @result = false
      for i in 1..(@mes_fin.to_i)
        @k = i.to_s

        @pagado_canon_fijo = 0
        @pagado_canon_variable = 0
        @total_pagado = 0
        @total_pagado_usd = 0
        @monto_x_cobrar = 0
        @suma_total_pagado_mes = 0
        @total_facturado = 0

        @tiendas_mall.each do |tienda|
          @cobranza_alquiler = CobranzaAlquiler.find_by('anio_alquiler = ? AND mes_alquiler = ? AND tienda_id = ?',@year,@k,tienda.id)

          if !(@cobranza_alquiler.blank?)
              @cobranza += @cobranza_alquiler.monto_alquiler
              @result = true
              if @cobranza_alquiler.saldo_deudor == 0
                @total_pagado += @cobranza_alquiler.monto_alquiler
                @total_pagado_usd += @cobranza_alquiler.monto_alquiler_usd
              else
                @monto_x_cobrar += @cobranza_alquiler.saldo_deudor
                @total_pagado +=  (@cobranza - @monto_x_cobrar)
                @total_pagado_usd += @total_pagado.to_f / CambioMoneda.last.cambio_ml_x_usd
              end
              @pagado_canon_fijo += @cobranza_alquiler.monto_canon_fijo
              @pagado_canon_variable += @cobranza_alquiler.monto_canon_variable
              @total_facturado += (@pagado_canon_fijo + @pagado_canon_variable)
          end
        end

        @suma_total_pagado += @total_pagado
        @suma_total_pagado_usd += @total_pagado_usd
        @suma_pagado_canon_fijo += @pagado_canon_fijo
        @suma_pagado_canon_variable += @pagado_canon_variable
        @suma_monto_x_cobrar += @monto_x_cobrar

        @obj = {
            'pagado_canon_fijo' => ActionController::Base.helpers.number_to_currency(@pagado_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'pagado_canon_variable' => ActionController::Base.helpers.number_to_currency(@pagado_canon_variable, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_facturado' => ActionController::Base.helpers.number_to_currency(@total_facturado, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_pagado' => ActionController::Base.helpers.number_to_currency(@total_pagado, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_pagado_usd' => ActionController::Base.helpers.number_to_currency(@total_pagado_usd, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'monto_cobrar' => ActionController::Base.helpers.number_to_currency(@monto_x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'mes' => @k
        }

        @cobranza_mes.push(@obj)
      end
      if @suma_pagado_canon_fijo.nil?
        @suma_pagado_canon_fijo = 0
      end
      if @suma_pagado_canon_variable.nil?
        @suma_pagado_canon_variable = 0
      end
      @suma_total_facturado += (@suma_pagado_canon_fijo + @suma_pagado_canon_variable)
      @totales = {
        'suma_total_facturado' => ActionController::Base.helpers.number_to_currency(@suma_total_facturado, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_total_pagado' => ActionController::Base.helpers.number_to_currency(@suma_total_pagado, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_total_pagado_usd' => ActionController::Base.helpers.number_to_currency(@suma_total_pagado_usd, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_pagado_canon_fijo' => ActionController::Base.helpers.number_to_currency(@suma_pagado_canon_fijo, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_pagado_canon_variable' => ActionController::Base.helpers.number_to_currency(@suma_pagado_canon_variable, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        'suma_monto_x_cobrar' => ActionController::Base.helpers.number_to_currency(@suma_monto_x_cobrar, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      }

      render json: [pagos: @cobranza_mes, totales: @totales, mes_actual: @mes_fin, result: @result]
    end
  end
end