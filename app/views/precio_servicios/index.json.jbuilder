json.array!(@precio_servicios) do |precio_servicio|
  json.extract! precio_servicio, :id, :fecha, :precio_usd
  json.url precio_servicio_url(precio_servicio, format: :json)
end
