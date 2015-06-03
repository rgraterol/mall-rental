#= require bootstrapValidator/bootstrapValidator.js
#= require input-mask/jquery.inputmask.js
#= require input-mask/jquery.inputmask.regex.extensions.js

jQuery(document).ready ($) ->

  $('#form_registro_cambio_moneda').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "cambio_moneda[cambio_ml_x_usd]":
        validators:
          notEmpty:
            message: 'Debe ingresar el valor'
          numeric:
            message: 'El valor debe ser numerico'

  $("#cambio_moneda_cambio_ml_x_usd").inputmask("Regex", {
    #regex: "[0-9.]{1,5}%"
    regex: "/^[0-9]+\.[0-9]{2}$|[0-9]+\.[0-9]{2}[^0-9]/"
  });
