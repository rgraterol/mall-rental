json.array!(@contrato_alquilers) do |contrato_alquiler|
  json.extract! contrato_alquiler, :id, :nro_contrato, :fecha_inicio, :fecha_fin, :archivo_contrato, :canon_fijo_ml, :canon_fijo_usd, :porc_canon_ventas, :estado_contrato, :tipo_canon_alquiler, :tienda_id
  json.url contrato_alquiler_url(contrato_alquiler, format: :json)
end
