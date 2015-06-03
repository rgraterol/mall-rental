#= require bootstrapValidator/bootstrapValidator.js

jQuery(document).ready ($) ->

  $('#form_registro_banco').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "banco[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar el nombre del banco'

  $('#form_edit_banco').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "banco[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar el nombre del banco'
