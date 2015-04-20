json.array!(@ventas) do |venta|
  json.extract! venta, :id, :fecha, :monto_ml, :monto_usd
  json.url venta_url(venta, format: :json)
end
