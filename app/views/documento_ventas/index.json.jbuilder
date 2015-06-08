json.array!(@documento_ventas) do |documento_venta|
  json.extract! documento_venta, :id, :titulo, :nomnbre
  json.url documento_venta_url(documento_venta, format: :json)
end
