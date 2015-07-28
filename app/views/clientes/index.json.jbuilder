json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :nombre, :RIF, :direccion, :telefono, :nombre_rl, :profesion_rl, :cedula_rl, :email_rl, :telefono_rl, :nombre_contacto, :profesion_contacto, :cedula_contacto, :email_contacto, :telefono_contacto
  json.url cliente_url(cliente, format: :json)
end
