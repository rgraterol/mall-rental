json.array!(@locals) do |local|
  json.extract! local, :id, :nombre, :rif
  json.url local_url(local, format: :json)
end
