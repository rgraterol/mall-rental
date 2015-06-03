#= require bootstrapValidator/bootstrapValidator.js

jQuery(document).ready ($) ->

  $('#form_registro_plantilla_contrato_alquiler').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "plantilla_contrato_alquiler[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar el nombre de la plantilla'
      "plantilla_contrato_alquiler[mall_id]":
        selector: '.mall_required'
        validators:
          notEmpty:
            message: "Mall es Obligatorio"
      "plantilla_contrato_alquiler[tipo_canon_alquiler_id]":
        selector: '.tipo_canon_alquiler_required'
        validators:
          notEmpty:
            message: "Tipo Canon de Alquiler es Obligatorio"
      "plantilla_contrato_alquiler[contenido]":
        validators:
          notEmpty:
            message: 'Debe ingresar el contenido de la plantilla'



