#= require bootstrapValidator/bootstrapValidator.js

jQuery(document).ready ->

  $('#form_registro_actividad_economica').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "actividad_economica[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre de la actividad economica'

  $('#form_edit_actividad_economica').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "actividad_economica[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre de la actividad economica'