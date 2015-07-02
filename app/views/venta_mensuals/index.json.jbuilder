json.array!(@venta_mensuals) do |venta_mensual|
  json.extract! venta_mensual, :id, :anio, :mes, :monto, :montoNotasCredito, :montoBruto, :montoBrutoUSD, :montoCostoVenta, :montoNeto, :montoNetoUSD, :editable
  json.url venta_mensual_url(venta_mensual, format: :json)
end
