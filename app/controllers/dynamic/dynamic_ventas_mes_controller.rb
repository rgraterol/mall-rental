module Dynamic
  class DynamicVentasMesController < ApplicationController
    respond_to :json
    def ventas
      year = params[:year]
      mall = current_user.mall

      totales = CobranzaAlquiler.get_total_cobranzas_xmes(mall,year)
      ventas_mes = VentaMensual.get_ventas_xmes(mall,year)
      suma_total = VentaMensual.suma_monto_bruto(mall,year)

      total_canon_x_ventas = ActionController::Base.helpers.number_to_currency(totales[:total_canon_variable], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      total_canon_fijo = ActionController::Base.helpers.number_to_currency(totales[:total_canon_fijo], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_total = ActionController::Base.helpers.number_to_currency(suma_total, separator: ',', delimiter: '.', format: "%n %u", unit: "")
      total_canons = ActionController::Base.helpers.number_to_currency(totales[:total_facturado], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      today = Time.now
      if (year == today.strftime("%Y"))
        mes_fin = today.strftime("%m").to_i - 1
      else
        mes_fin = 12
      end
      render json: [ventas: ventas_mes, result: true, suma_total: suma_total, total_canon_x_ventas: total_canon_x_ventas, total_canon_fijo: total_canon_fijo, total_canons: total_canons, mes_fin: mes_fin]
    end
  end
end