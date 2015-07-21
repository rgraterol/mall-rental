module Dynamic
  class DynamicVentaAuditoriaController < ApplicationController
    respond_to :json

    def auditoria
      @year = params[:year]
      @month = params[:month]

      ventas_mall_tiendas = Tienda.get_ventas_xtienda(current_user.mall,@year,@month)
      obj = obj
      array_tienda = Array.new
      cant = ventas_mall_tiendas.count()-1
      (0 .. cant).each do |pos|
        venta = ventas_mall_tiendas[pos][:tienda]

        obj = {
            'tienda_id' => venta.id,
            'tienda' => venta.nombre,
            'actividad_economica' => venta.actividad_economica.nombre,
            'local' => venta.local.nro_local,
            'nivel_ubicacion' => venta.nivel_mall.nombre,
            'tipo_canon' => ventas_mall_tiendas[pos][:tipo_canon],
            'canon_fijo' => ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:canon_fijo], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'canon_variable' => ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:canon_variable], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'ventas_bruto_mes' => ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:ventas_bruto_mes], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_canon' => ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:total_canon], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            # 'actualizada' => @actualizada,
            'recibos_cobro' => ventas_mall_tiendas[pos][:tiene_cobranza_mes],
            # 'dias_loborables' => @cantidad_dias_laborables,
            # 'cantidad_ventas' => @cantidad_ventas_mes,
            # 'editable_mensual' => @editable,
            'monto_venta' => ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:suma_ventas_tiendas], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'monto_venta_bruto' =>  ActionController::Base.helpers.number_to_currency(@monto_venta_bruto, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
        }
        array_tienda.push(obj)
      end

      # @total_s = @suma_canon_fijo + @suma_canon_ventas
      total_ventas = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_ventas_tiendas], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_monto_venta_bruto = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_ventas_bruto_tiendas], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_canon_fijo = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_canon_fijo], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_canon_variable = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_canon_variable], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_total_canon = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_total_canon], separator: ',', delimiter: '.', format: "%n %u", unit: "")

      render json: [ result: true, cont: @cantidad_dias_laborables, tiendas: array_tienda, suma_canon_variable: suma_canon_variable, suma_canon_fijo: suma_canon_fijo, suma_total_canon: suma_total_canon, total_ventas: total_ventas, tiendas_cont: @contrato_alquiler, mes: @month, total_ventas_bruto: suma_monto_venta_bruto]
    end
  end
end