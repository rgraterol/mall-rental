#= require input-mask/jquery.inputmask.js
#= require input-mask/jquery.inputmask.regex.extensions.js
#= require bootstrapValidator/bootstrapValidator
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
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: 'Canón Fijo en Bs. obligatorio para tipo Canón Fijos'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'canon_fijo' or canon == 'fijo_y_variable_venta_bruta' or canon == 'fijo_y_variable_venta_neta') and value == ''
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
              if (canon == 'porcentaje_de_ventas' or canon == 'fijo_y_variable_venta_bruta' or canon == 'fijo_y_variable_venta_neta') and value == ''
                false
              else
                true

  calcular_monto_minimo_venta()

  $("#porc_canon_tienda").inputmask("Regex", {
    regex: "[0-9.]{1,5}%"
  });
  $('#canon_fijo_tienda').inputmask("Regex", {
    regex: "[0-9.]{1,25}%"
  });

  $('#select_canon_alquiler').change ->
    if $(this).val() == 'fijo'
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').hide()
      $('#canon_porcentaje').find(':input').prop('disabled', true);
      $('#requerida_venta_check').prop('disabled', false).prop('checked', true);
    else if ($(this).val() == 'fijo_y_variable_venta_bruta' || $(this).val() == 'fijo_y_variable_venta_neta')
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
      $('#requerida_venta_check').prop('disabled', true).prop('checked', true);
      calcular_monto_minimo_venta()
    else if $(this).val() == 'variable'
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
      $('#canon_fijo').hide()
      $('#canon_fijo').find(':input').prop('disabled', true);
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
      value = $('#canon_fijo_tienda').val()/($(this).val()/100)
    $('#monto_minimo_tienda').val value

  $('#canon_fijo_tienda').keyup ->
    if $('#porc_canon_tienda').val() == ''
      value = 0
    else
      value = $(this).val()/($('#porc_canon_tienda').val()/100)
      $('#monto_minimo_tienda').val value
    $.ajax
      type: "POST"
      url: "/cambio_monedas/mf_cambio_moneda/"
      dataType: "JSON"
      data:
        ml: $(this).val()
      success: (data) ->
        $('.canon_fijo_usd').val(data)

key_up_porc_venta = ->
  $('#porc_canon_tienda').keyup ->
    if $(this).val() > 100
      $(this).val 100
    $('#monto_minimo_tienda').val 0