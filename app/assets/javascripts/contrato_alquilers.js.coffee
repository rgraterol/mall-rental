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
            message: 'Canón Fijo en Bs. obligatorio para tipo Canón Fijo'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'canon_fijo' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true
      "contrato_alquiler[canon_fijo_usd]":
        validators:
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: 'Canón Fijo en $. obligatorio para tipo Canón Fijo'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'canon_fijo' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true
      "contrato_alquiler[porc_canon_ventas]":
        validators:
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: '% Canón por Ventas obligatorio para tipo de canón Porcentaje de Ventas'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'porcentaje_de_ventas' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true
      "contrato_alquiler[monto_minimo_ventas]":
        validators:
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: 'Monto Mínimo de Ventas Mensual obligatorio para tipo de canón Porcentaje de Ventas'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'porcentaje_de_ventas' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true


  $('#select_canon_alquiler').change ->
    if $(this).val() == 'canon_fijo'
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').hide()
      $('#canon_porcentaje').find(':input').prop('disabled', true);
    else if $(this).val() == 'canon_fijo_y_porcentaje_ventas'
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
    else if $(this).val() == 'porcentaje_de_ventas'
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
      $('#canon_fijo').hide()
      $('#canon_fijo').find(':input').prop('disabled', true);

    else
      $('#canon_fijo').hide()
      $('#canon_fijo').find(':input').prop('disabled', true);
      $('#canon_porcentaje').hide()
      $('#canon_porcentaje').find(':input').prop('disabled', true);