#= require datapicker/bootstrap-datepicker.js
#= require jasny/jasny-bootstrap
#= require bootstrapValidator/bootstrapValidator.js

jQuery(document).ready ($) ->

  $(".actualizar_pagos_mensuales").change()
  $('#fecha_pago').datepicker
    keyboardNavigation: false
    forceParse: false
    autoclose: true
    format: 'dd/mm/yyyy'
    language: 'es'

  $('#form_registro_pago_transferencia').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "pago_alquiler[monto_alquiler_ml]":
        validators:
          notEmpty:
            message: 'Debe ingresar el monto de la transferencia'
          numeric:
            message: 'El valor debe ser numerico'
      "pago_alquiler[fecha_pago]":
        validators:
          notEmpty:
            message: 'Debe ingresar la fecha de pago'
      "pago_alquiler[nro_cheque_confirmacion]":
        validators:
          notEmpty:
            message: 'Debe ingresar el numero de confirmacion'
      "pago_alquiler[cuenta_bancaria_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar la cuenta bancaria'
      "pago_alquiler[nombre_banco]":
        validators:
          notEmpty:
            message: 'Debe ingresar el nombre del banco emisor de la transferencia'

  $('#form_registro_pago_cheque').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "pago_alquiler[tienda]":
        validators:
          notEmpty:
            message: 'Debe seleccionar una tienda'
      "pago_alquiler[monto_alquiler_ml]":
        validators:
          notEmpty:
            message: 'Debe ingresar el monto de la transferencia'
          numeric:
            message: 'El valor debe ser numerico'
      "pago_alquiler[fecha_pago]":
        validators:
          notEmpty:
            message: 'Debe ingresar la fecha de pago'
      "pago_alquiler[nro_cheque_confirmacion]":
        validators:
          notEmpty:
            message: 'Debe ingresar el numero del cheque'
      "pago_alquiler[cuenta_bancaria_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar la cuenta bancaria'
      "pago_alquiler[nombre_banco]":
        validators:
          notEmpty:
            message: 'Debe ingresar el nombre del banco del cheque'
      "pago_alquiler[tipo_pago]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el tipo de pago'
          callback:
            message: 'Debe ingresar cuenta bancaria y nro de confirmacion'
            callback: (value, validator, $field) ->
              if value == '' && $("#pago_alquiler_cuenta_bancaria_id").val() == '' && $("#pago_alquiler_nro_cheque_confirmacion").val() == '' && $("#pago_alquiler_nombre_banco").val() == ''
                false
              else
                true


$("#pago_alquiler_tipo_pago").on "change", ->
  if (this.value) != 'Cheque'
    $("#rowCuenta").hide()
    $("#rowNumero").hide()
    $("#rowBanco").hide()
  else
    $("#rowCuenta").show()
    $("#rowNumero").show()
    $("#rowBanco").show()

$(".actualizar_pagos_alquiler").on "change", ->
  $.ajax
    type: "POST"
    url: "/dynamic_pago_alquilers/actualizar_pagos"
    dataType: "JSON"
    data:
      year: $("#date_lapso_year").val()
      month: $("#pagos_alquiler_select_month").val()
    success: (data) ->

      $("#tbody_pagos_alquiler").empty()
      console.log(data)
      if data[0]['cont'] > 0
        for element, index in data[0]['pago_alquilers']

          @cadena_check = ''
          @cadena_check_2 = ''

          if element.pago.pagado
            @cadena_check = "checked title='Pago Realizado'"
          if element.pago.facturado
            @cadena_check_2 = "checked title='Pago Facturado'"

          nro = if element.pago.nro_cheque_confirmacion then element.pago.nro_cheque_confirmacion else ''
          fecha = if element.pago.fecha_pago then element.pago.fecha_pago else ''
          facturado = if element.pago.facturado then true else false
          nro_fact = if element.pago.nro_factura then element.nro_factura else ''
          fecha_fact = if element.pago.fecha_factura then element.fecha_factura else ''
          monto = element.monto_pagado

          $("#monto_cobrar").val(data[0].suma_x_cobrar)
          console.log(data)
          $("#input_suma_monto_alquiler").val(data[0].suma)
          $("#input_suma_monto_pagado").val(data[0].suma_monto_pagado)

          $("#tbody_pagos_alquiler").append("<tr>" +
            "<td>"+element.tienda+"</td>"+
            "<td class='text-center'>"+element.pago.nro_recibo+"</td>"+
            "<td>"+element.pago.fecha_recibo_cobro+"</td>"+
            "<td class='text-right'>"+element.monto_alquiler+"</td>"+
            "<td class='text-center'><input type='checkbox' disabled='disabled' name='alquiler_pagado' value='"+element.pago.pagado+"' "+@cadena_check+" /></td>"+
            "<td class='text-right'>"+monto+"</td>"+
            "<td>"+element.tipo_pago+"</td>"+
            "<td>"+fecha+"</td>"+
            "<td>"+nro+"</td>"+
            "<td>"+element.banco+"</td>"+
            "<td class='text-center'><input type='checkbox' disabled='disabled' name='pago_facturado' value='"+facturado+"' "+@cadena_check_2+" /></td>"+
            "<td>"+nro_fact+"</td>"+
            "<td>"+fecha_fact+"</td>"+
            "</tr>")
          $("#tfoot_pagos_alquiler").show()
      else
        $("#monto_cobrar").val('0,00')
        $("#tfoot_pagos_alquiler").hide()
        $("#tbody_pagos_alquiler").append("<tr><td colspan=13 class='text-center'>No existen registros de pago para este periodo</td></tr>")

    error: (data)->
      console.log(data)
    complete: ->
      a=1

$(".actualizar_pagos_mensuales").on "change", ->
  $.ajax
    type: "POST"
    url: "/dynamic_pago_alquilers_mensuales/pagos"
    dataType: "JSON"
    data:
      year: $("#date_lapso_year").val()
    success: (data) ->
      $("#tbody_pagos_mensuales_mall").empty()
      meses = ['Enero', 'Febrero', 'Marzo', 'Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']
      mes_fin = data[0]['mes_actual']-1

      console.log(data)

      for num in [0..mes_fin]
        $("#tbody_pagos_mensuales_mall").append("<tr><th>"+meses[num]+"</th><td>"+data[0]['pagos'][num].total_cobranza+"</td><td>"+data[0]['pagos'][num].pagado_canon_fijo+"</td><td>"+data[0]['pagos'][num].pagado_x_ventas+"</td><td>"+data[0]['pagos'][num].total_pagado+"</td><td>"+data[0]['pagos'][num].total_pagado_usd+"</td><td>"+data[0]['pagos'][num].monto_cobrar+"</td><td><a href='/ventas_mall_tiendas/2/"+(num+1)+"'>Ver Detalles de Pagos</a></td></tr>")

      $("#suma_cobranza").text(data[0]['totales']['suma_cobranza'])
      $("#suma_pagado_canon_fijo").text(data[0]['totales']['suma_pagado_canon_fijo'])
      $("#suma_pagado_x_ventas").text(data[0]['totales']['suma_pagado_x_ventas'])
      $("#suma_total_pagado").text(data[0]['totales']['suma_total_pagado'])
      $("#suma_total_pagado_usd").text(data[0]['totales']['suma_total_pagado_usd'])
      $("#suma_monto_x_cobrar").text(data[0]['totales']['suma_monto_x_cobrar'])

    error: (data)->
      console.log(data)
    complete: ->
      a=1

