json.array!(@actividad_economicas) do |actividad_economica|
  json.extract! actividad_economica, :id, :nombre
  json.url actividad_economica_url(actividad_economica, format: :json)
end
