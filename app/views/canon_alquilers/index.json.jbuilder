json.array!(@canon_alquilers) do |canon_alquiler|
  json.extract! canon_alquiler, :id, :fecha, :canon_fijo_ml, :canon_fijo_usd, :porc_canon_ventas, :monto_minimo_ventas
  json.url canon_alquiler_url(canon_alquiler, format: :json)
end
