json.array!(@locals) do |local|
  json.extract! local, :id, :nombre, :rif, :direccion
  json.url local_url(local, format: :json)
end
