json.array!(@pago_alquilers) do |pago_alquiler|
  json.extract! pago_alquiler, :id
  json.url pago_alquiler_url(pago_alquiler, format: :json)
end
