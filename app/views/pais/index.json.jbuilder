json.array!(@pais) do |pai|
  json.extract! pai, :id, :nombre
  json.url pai_url(pai, format: :json)
end
