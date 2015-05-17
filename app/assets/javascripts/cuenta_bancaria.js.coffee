#= require bootstrapValidator/bootstrapValidator.js
#= require jasny/jasny-bootstrap.min
#= require jquery.blockUI.js
#= require dataTables/jquery.dataTables.js
#= require dataTables/dataTables.bootstrap.js
#= require dataTables/dataTables.responsive.js
#= require dataTables/dataTables.tableTools.min.js

jQuery(document).ready ->
  $('#form_registro_cuenta').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "cuenta_bancarium[nro_cta]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Numero de Cuenta'
      "cuenta_bancarium[tipo_cuenta]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Tipo de Cuenta'
      "cuenta_bancarium[beneficiario]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Beneficiario'
      "cuenta_bancarium[doc_identidad]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Documento de Identidad'
      "cuenta_bancarium[banco]":
        selector: '#cuenta_bancarium_banco_id'
        validators:
          notEmpty:
            message: 'Debe seleccionar el Banco'

  $('#form_edit_cuenta').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "cuenta_bancarium[nro_cta]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Numero de Cuenta'
      "cuenta_bancarium[tipo_cuenta]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Tipo de Cuenta'
      "cuenta_bancarium[beneficiario]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Beneficiario'
      "cuenta_bancarium[doc_identidad]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Documento de Identidad'
      "cuenta_bancarium[banco]":
        selector: '#cuenta_bancarium_banco_id'
        validators:
          notEmpty:
            message: 'Debe seleccionar el Banco'
