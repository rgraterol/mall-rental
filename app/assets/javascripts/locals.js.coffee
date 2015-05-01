#= require bootstrapValidator/bootstrapValidator.js
#= require jasny/jasny-bootstrap.min
#= require jquery.blockUI.js

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
      "local[tipo_local_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el Tipo de Local'
      "local[tipo_estado_local]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el Estado del Local'


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
      "local[tipo_local_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el Tipo de Local'
      "local[tipo_estado_local]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el Estado del Local'

$("#local_nivel_mall_id").append("<option value='999'>Nuevo...</option>")
$("#local_nivel_mall_id").on "change", ->
  if (this.value) == '999'
    $(".mostrar").css "display","none"
    $(".oculto").css "display","block"
    $("#validacion_nombre_nivel").css "display","none"
    $("#validacion_nombre_en_uso_nivel").css "display","none"
$("#icon-deshacer-new-nivel").on "click", ->
  $(".mostrar").css "display","block"
  $(".oculto").css "display","none"
  $("#validacion_nombre_nivel").css "display","none"
  $("#validacion_nombre_en_uso_nivel").css "display","none"
  $("#local_nivel_mall_id").val('')
  $("#nivel_mall_new").val('')

$("#icon-save-new-nivel").on "click", ->
  valor = $("#nivel_mall_new").val()
  if(valor != '')
    $("#validacion_nombre_nivel").css "display","none"
    if confirm("Esta seguro de guardar el nuevo Nivel Mall")
      $.ajax
        type: "POST"
        url: "/dynamic_add_nivel_mall/guardar"
        dataType: "JSON"
        async: false
        data:
          nombre: valor
        success: (data) ->
          console.log(data)
          $("#local_nivel_mall_id").append("<option value='"+data.id+"'>"+data.nombre+"</option>")
          $("#local_nivel_mall_id").val(data.id)
          $(".mostrar").css "display","block"
          $(".oculto").css "display","none"
          $.blockUI({
            message: 'Ubicacion Nivel se guardado exitosamente',
            timeout: 2000,
          });
        error: (data)->
          $("#validacion_nombre_en_uso_nivel").css "display","block"
          console.log(data)
        complete: ->
          a=1
  else
    $("#validacion_nombre_nivel").css "display","block"

  $("#nivel_mall_new").on "focus", ->
    $("#validacion_nombre_en_uso_nivel").css "display","none"
    $("#validacion_nombre_nivel").css "display","none"

