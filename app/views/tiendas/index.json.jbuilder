json.array!(@tiendas) do |tienda|
  json.extract! tienda, :id
  json.url tienda_url(tienda, format: :json)
end
