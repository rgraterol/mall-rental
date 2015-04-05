json.array!(@nivel_malls) do |nivel_mall|
  json.extract! nivel_mall, :id, :nombre
  json.url nivel_mall_url(nivel_mall, format: :json)
end
