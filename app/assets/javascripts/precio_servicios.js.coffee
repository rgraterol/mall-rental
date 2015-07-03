#= require bootstrapValidator/bootstrapValidator.js
#= require input-mask/jquery.inputmask.js
#= require input-mask/jquery.inputmask.regex.extensions.js
#= require datapicker/bootstrap-datepicker.js

jQuery(document).ready ($) ->

  $('#fecha_calendario_precio').datepicker
    keyboardNavigation: false
    forceParse: false
    autoclose: true
    format: 'dd/mm/yyyy'
    language: 'es'

  $('#form_precio_servicio').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "precio_servicio[fecha]":
        validators:
          notEmpty:
            message: 'Debe ingresar la fecha'
      "precio_servicio[precio_usd]":
        validators:
          notEmpty:
            message: 'Debe ingresar el valor'
          numeric:
            message: 'El valor debe ser numerico'
      "precio_servicio[tipo_servicio_id]":
        validators:
          notEmpty:
            message: "Debe seleccionar el tipo de servicio, campo Obligatorio"
      "precio_servicio[tipo_contrato_servicio_id]":
        validators:
          notEmpty:
            message: "Debe seleccionar el tipo de contrato del Servicio, campo Obligatorio"
