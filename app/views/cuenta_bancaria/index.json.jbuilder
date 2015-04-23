json.array!(@cuenta_bancaria) do |cuenta_bancarium|
  json.extract! cuenta_bancarium, :id, :nroCta, :tipoCuenta, :beneficiario, :docIdentidad
  json.url cuenta_bancarium_url(cuenta_bancarium, format: :json)
end
