#= require bootstrapValidator/bootstrapValidator.js
#= require jasny/jasny-bootstrap.min

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
      "local[area]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Área del Local'
      "local[area_planta]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Área de la Planta'
          numeric:
            message: 'Debe ser numerico'
      "local[area_terraza]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Área de la Terraza'
        numeric:
          message: 'Debe ser numerico'
      "local[area_mezanina]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Área de la Mezanina'
          numeric:
            message: 'Debe ser numerico'
      "local[nivel_mall_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el Nivel Ubicacion'


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
      "local[area]":
        validators:
          notEmpty:
            message: 'Debe ingresar el Área del Local'

  $("#local_nivel_mall_id").append("<option value='999'>Nuevo...</option>")
  $("#local_nivel_mall_id").on "change", ->
    if (this.value) == '999'
      $(".mostrar").css "display","none"
      $(".oculto").css "display","block"
  $("#icon-deshacer-new-nivel").on "click", ->
    $(".mostrar").css "display","block"
    $(".oculto").css "display","none"
  $("#icon-save-new-nivel").on "click", ->
    if confirm("Esta seguro de guardar el nuevo Nivel Mall")
      alert("guardar")



