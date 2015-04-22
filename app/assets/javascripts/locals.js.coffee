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
      $(".group-show").css "display","none"
      $(".group-oculto").css "display","block"
  $("#icon-deshacer-new-nivel").on "click", ->
    $(".group-show").css "display","block"
    $(".group-oculto").css "display","none"
  $("#icon-save-new-nivel").on "click", ->
    if confirm("Esta seguro de guardar el nuevo Nivel Mall")
      alert("guardar")



