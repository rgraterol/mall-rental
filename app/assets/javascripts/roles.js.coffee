#= require bootstrapValidator/bootstrapValidator.js

jQuery(document).ready ($) ->
  $('#role_form').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "role[name]":
        validators:
          notEmpty:
            message: 'Nombre de Rol es Obligatorio.'
      "role[role_type]":
        validators:
          notEmpty:
            message: 'Tipo de Rol es Obligatorio.'
      "role[tipo_servicio_id]":
        validators:
          notEmpty:
            message: 'Tipo de Servicio es Obligatorio.'