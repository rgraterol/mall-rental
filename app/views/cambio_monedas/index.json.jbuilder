json.array!(@cambio_monedas) do |cambio_moneda|
  json.extract! cambio_moneda, :id, :fecha, :cambio_ml_x_usd
  json.url cambio_moneda_url(cambio_moneda, format: :json)
end
