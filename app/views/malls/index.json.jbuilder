json.array!(@malls) do |mall|
  json.extract! mall, :id, :nombre, :abreviado, :rif, :direccion_fiscal, :telefono
  json.url mall_url(mall, format: :json)
end
