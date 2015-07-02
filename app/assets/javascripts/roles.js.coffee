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

  $('#mall_id_mall_id').change ->
    if $(this).val() != ''
      $.ajax
        type: "POST"
        url: "/set_mall"
        dataType: "HTML"
        data:
          mall_id: $(this).val()
        success: (data) ->
          $('#mall_assing').empty()
          $('#mall_assing').append(data)