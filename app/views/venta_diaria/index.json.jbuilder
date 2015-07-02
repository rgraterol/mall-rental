json.array!(@venta_diaria) do |venta_diarium|
  json.extract! venta_diarium, :id, :fecha, :monto, :monto_notas_credito, :monto_bruto, :monto_bruto_usd, :monto_costo_venta, :monto_neto, :monto_neto_usd, :editable
  json.url venta_diarium_url(venta_diarium, format: :json)
end
