#= require bootstrapValidator/bootstrapValidator.js

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
