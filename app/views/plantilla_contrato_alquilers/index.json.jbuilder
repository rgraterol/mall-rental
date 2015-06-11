json.array!(@plantilla_contrato_alquilers) do |plantilla_contrato_alquiler|
  json.extract! plantilla_contrato_alquiler, :id, :nombre, :contenido
  json.url plantilla_contrato_alquiler_url(plantilla_contrato_alquiler, format: :json)
end
