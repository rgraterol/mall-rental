#= require datapicker/bootstrap-datepicker.js
#= require bootstrapValidator/bootstrapValidator.js

jQuery(document).ready ($) ->

  $('#fecha_pago').datepicker
    keyboardNavigation: false
    forceParse: false
    autoclose: true
    format: 'dd/mm/yyyy'
    language: 'es'

  $('#form_registro_pago_transferencia').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "pago_alquiler[monto_alquiler_ml]":
        validators:
          notEmpty:
            message: 'Debe ingresar el monto de la transferencia'
      "pago_alquiler[fecha_pago]":
        validators:
          notEmpty:
            message: 'Debe ingresar la fecha de pago'
      "pago_alquiler[nro_cheque_confirmacion]":
        validators:
          notEmpty:
            message: 'Debe ingresar el numero de confirmacion'
      "pago_alquiler[cuenta_bancaria_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar la cuenta bancaria'

