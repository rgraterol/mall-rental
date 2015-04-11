jQuery(document).ready ->

  $('#form_registro_local').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "local[nro_local]":
        validators:
          notEmpty:
            message: 'Debe ingresar un N° de Local'
          integer:
            message: 'Este valor debe ser solo número entero'
      "local[area]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Área del Local'

  $('#form_edit_local').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "local[nro_local]":
        validators:
          notEmpty:
            message: 'Debe ingresar un N° de Local'
          integer:
            message: 'Este valor debe ser solo número entero'
      "local[area]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Área del Local'