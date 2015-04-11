json.array!(@calendario_no_laborables) do |calendario_no_laborable|
  json.extract! calendario_no_laborable, :id, :fecha, :motivo
  json.url calendario_no_laborable_url(calendario_no_laborable, format: :json)
end
