#= require input-mask/jquery.inputmask.js
#= require input-mask/jquery.inputmask.regex.extensions.js
#= require bootstrapValidator/bootstrapValidator
#= require jasny/jasny-bootstrap
#= require numeric

jQuery(document).ready ->

  $('#contrato_alquiler_form').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "contrato_alquiler[tipo_canon_alquiler]":
        validators:
          notEmpty:
            message: 'Tipo Canon de Alquiler es Obligatorio'
      "contrato_alquiler[canon_fijo_ml]":
        validators:
          callback:
            message: 'Canón Fijo en Bs. obligatorio para tipo Canón Fijos'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == '1' or canon == '4' or canon == '5') and (value == '' || value == '0.0' || value == '0')
                false
              else
                true
      "contrato_alquiler[porc_canon_ventas]":
        validators:
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: '% Canón por Ventas obligatorio para tipo de Canón Variables'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == '2' or canon == '3' or canon == '4' or canon == '5') and (value == '' || value == '0.0' || value == '0')
                false
              else
                true

  calcular_monto_minimo_venta()

  $("#porc_canon_tienda").inputmask("Regex", {
    regex: "[0-9.]{1,5}%"
  });
  $('#canon_fijo_tienda').inputmask("Regex", {
    regex: "[0-9,.]{1,25}%"
  });

  $('#select_canon_alquiler').change ->
    if $(this).val() == '1'
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').hide()
      $('#canon_porcentaje').find(':input').prop('disabled', true);
      $('#requerida_venta_check').prop('disabled', false).prop('checked', true);
    else if ($(this).val() == '4' || $(this).val() == '5')
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
      $('#requerida_venta_check').prop('disabled', true).prop('checked', true);
      calcular_monto_minimo_venta()
    else if ($(this).val() == '2' || $(this).val() == '3')
      $('#canon_fijo').hide()
      $('#canon_fijo').find(':input').prop('disabled', true);
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
      $('#monto_minimo_tienda').val('0')
      $('#requerida_venta_check').prop('disabled', true).prop('checked', true);
      key_up_porc_venta()
    else
      $('#canon_fijo').hide()
      $('#canon_fijo').find(':input').prop('disabled', true);
      $('#canon_porcentaje').hide()
      $('#canon_porcentaje').find(':input').prop('disabled', true);
      $('#requerida_venta_check').prop('disabled', true).prop('checked', false);


calcular_monto_minimo_venta = ->
  $('#porc_canon_tienda').keyup ->
    if $(this).val() > 100
      $(this).val 100
    if $(this).val() == ''
      value = 0
    else
      value = $('#canon_fijo_tienda').val().replace(',', '')/($(this).val()/100)
    $('#monto_minimo_tienda').val value.toFixed(2)

  $('#canon_fijo_tienda').keyup ->
    if $('#porc_canon_tienda').val() == ''
      value = 0
    else
      value = $(this).val().replace(',', '')/($('#porc_canon_tienda').val()/100)
      $('#monto_minimo_tienda').val value.toFixed(2)
    $.ajax
      type: "POST"
      url: "/cambio_monedas/mf_cambio_moneda/"
      dataType: "JSON"
      data:
        ml: $(this).val()
      success: (data) ->
        $('.canon_fijo_usd').val(data.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"))

key_up_porc_venta = ->
  $('#porc_canon_tienda').keyup ->
    if $(this).val() > 100
      $(this).val 100
    $('#monto_minimo_tienda').val 0