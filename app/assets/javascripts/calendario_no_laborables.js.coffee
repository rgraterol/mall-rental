#= require datapicker/bootstrap-datepicker.js
#= require bootstrapValidator/bootstrapValidator.js


jQuery(document).ready ($) ->

  $('#fecha_calendario_nl').datepicker
    keyboardNavigation: false
    forceParse: false
    autoclose: true
    format: 'dd/mm/yyyy'
    language: 'es'

  $('#form_registro_calendario').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "calendario_no_laborable[motivo]":
        validators:
          notEmpty:
            message: 'Debe ingresar el motivo'