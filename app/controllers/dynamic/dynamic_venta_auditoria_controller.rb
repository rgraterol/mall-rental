module Dynamic
  class DynamicVentaAuditoriaController < ApplicationController
    respond_to :json

    def auditoria
      year = params[:year]
      month = params[:month]

      ventas_mall_tiendas = Tienda.get_ventas_xtienda(current_user.mall,year,month)
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
            'venta_neta_mes' => ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:venta_neta_mes], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'monto_venta' => ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:suma_ventas_tiendas], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'monto_venta_bruto' =>  ActionController::Base.helpers.number_to_currency(@monto_venta_bruto, separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'total_monto_ventas' =>  ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[pos][:total_monto_ventas], separator: ',', delimiter: '.', format: "%n %u", unit: ""),
            'editable' => ventas_mall_tiendas[pos][:editable],
        }
        array_tienda.push(obj)
      end

      total_monto_ventas = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:total_monto_ventas], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_monto_venta_neta = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_venta_neta], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_monto_venta_bruto = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_ventas_bruto_tiendas], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_canon_fijo = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_canon_fijo], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_canon_variable = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_canon_variable], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_total_canon = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_total_canon], separator: ',', delimiter: '.', format: "%n %u", unit: "")
      suma_total_ventas = ActionController::Base.helpers.number_to_currency(ventas_mall_tiendas[cant][:suma_total_ventas], separator: ',', delimiter: '.', format: "%n %u", unit: "")

      render json: [ result: true, tiendas: array_tienda, suma_canon_variable: suma_canon_variable, suma_canon_fijo: suma_canon_fijo, suma_total_canon: suma_total_canon, suma_total_ventas: suma_total_ventas, mes: month, total_ventas_bruto: suma_monto_venta_bruto, total_ventas_neta: suma_monto_venta_neta ]
    end
  end
end