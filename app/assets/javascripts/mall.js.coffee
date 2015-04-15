#= require bootstrapValidator/bootstrapValidator.js

jQuery(document).ready ->

  $('#form_registro_mall').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "mall[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre del mall'
      "mall[abreviado]":
        validators:
          notEmpty:
            message: 'Debe ingresar una abreviatura del mall'
      "mall[rif]":
        validators:
          notEmpty:
            message: 'Debe ingresar el RIF del mall'
      "mall[direccion_fiscal]":
        validators:
          notEmpty:
            message: 'Debe ingresar la direccion fiscal del mall'
      "mall[telefono]":
        validators:
          notEmpty:
            message: 'Debe ingresar el telefono del mall'

  $('#form_edit_mall').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "mall[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre del mall'
      "mall[abreviado]":
        validators:
          notEmpty:
            message: 'Debe ingresar una abreviatura del mall'
      "mall[rif]":
        validators:
          notEmpty:
            message: 'Debe ingresar el RIF del mall'
      "mall[direccion_fiscal]":
        validators:
          notEmpty:
            message: 'Debe ingresar la direccion fiscal del mall'
      "mall[telefono]":
        validators:
          notEmpty:
            message: 'Debe ingresar el telefono del mall'