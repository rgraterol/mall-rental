#= require datapicker/bootstrap-datepicker.js
#= require jasny/jasny-bootstrap
#= require bootstrapValidator/bootstrapValidator.js
#= require jquery.blockUI.js
#= require jquery.number.js

jQuery(document).ready ($) ->

  #$(".actualizar_pagos_mensuales").change()

  $(".monto_numerico").number(true,2,',','.')

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
      "monto_campo":
        validators:
          callback:
            message: 'Debe seleccionar el monto del pago'
            callback: (value, validator, $field) ->
              if $("#pago_alquiler_monto").val() == '' || $("#pago_alquiler_monto").val() <= 0
                false
              else
                true
      "pago_alquiler[fecha]":
        validators:
          notEmpty:
            message: 'Debe ingresar la fecha de pago'
      "pago_alquiler[nro_cheque_confirmacion]":
        validators:
          notEmpty:
            message: 'Debe ingresar el numero de confirmacion'
      "pago_alquiler[cuenta_bancarium_id]":
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
      "tienda[id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar una tienda'
      "monto_campo":
        validators:
          callback:
            message: 'Debe seleccionar el monto del pago'
            callback: (value, validator, $field) ->
              if $("#pago_alquiler_monto").val() == '' || $("#pago_alquiler_monto").val() <= 0
                false
              else
                true
      "pago_alquiler[fecha]":
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
            message: 'Debe seleccionar la cuenta bancaria a depositar'
      "pago_alquiler[banco_emisor]":
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
              if value == '' && $("#pago_alquiler_cuenta_bancarium_id").val() == '' && $("#pago_alquiler_nro_cheque_confirmacion").val() == '' && $("#pago_alquiler_nombre_banco").val() == ''
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
    url: "/pago_alquilers/actualizar_pagos"
    dataType: "HTML"
    data:
      year: $("#date_lapso_year").val()
      month: $("#pagos_alquiler_select_month").val()
    before_send: $.blockUI({message: 'Por favor espere...'})
    success: (data) ->
      html = $('#wrapper')
      html.empty()
      html.append(data)
    error: (data)->
      console.log(data)
    complete: ->
      $.unblockUI()

$(".actualizar_pagos_mensuales").on "change", ->
  $.ajax
    type: "POST"
    url: "/pago_alquilers/pagos"
    dataType: "HTML"
    data:
      year: $("#date_lapso_year").val()
    before_send: $.blockUI({message: 'Por favor espere...'})
    success: (data) ->
      $("#tbody_pagos_mensuales_mall").empty()
      html = $("#tbody_pagos_mensuales_mall")
      html.empty()
      html.append(data)
    error: (data)->
      console.log(data)
    complete: ->
      $.unblockUI()

$(".tbody_facturas_pendientes").on
  click:->
    if $('input',this).length == 0
      valor = $(this).text()
      fecha = $(this).attr('fecha')
      id = $(this).attr('campo')
      $(this).text('')
      $(this).append("<input  type='text' value='"+valor+"' id='venta_"+id+"' valor='"+valor+"' codigo='"+fecha+"' campo='"+id+"'></input>")
      $('input',this).number(true,2,',','.')
      $('input',this).focus()
  ".editar_monto_pago"

$(".tbody_facturas_pendientes").on
  blur:->
    if ($(this).val() != '')
      $(this).parent().attr('valor',$(this).val())
      $(this).parent().addClass('campo_editar')
      monto = $(this).number(true,2,',','.')
      $(this).parent().number(monto.val(),2,',','.')
      $(this).remove()
    else
      $(this).parent().text($(this).val())
      $(this).remove()
  ".editar_monto_pago input"

$(".tbody_facturas_pendientes").on
  click:->
    campo = $(this).attr('campo')
    valor = $(this).val()
    factura = $("#monto_factura_"+campo).text()
    monto = $("#monto_factura_"+campo).attr('valor_campo')
    if valor == 'total'
      $("#monto_pago_"+campo).text(factura)
      $("#monto_pago_"+campo).attr('valor',monto)
      calcular_a_pagar(campo)
    else
      $("#monto_pago_"+campo).addClass('editar_monto_pago')
      campo_monto_pago = $("#monto_pago_"+campo)
      valor = campo_monto_pago.text()
      valor = $.trim(valor)
      campo_monto_pago.text('')
      campo_monto_pago.append("<input  type='text' value='"+valor+"' id='pago_"+campo+"' valor='"+valor+"' campo='"+campo+"'></input>")
  ".alquiler_pago"

$(".tbody_facturas_pendientes").on
  keyup:->
    campo = $(this).attr('campo')
    elemento = $('#monto_pago_'+campo)
    factura = $("#monto_factura_"+campo).text()
    monto_factura = $("#monto_factura_"+campo).attr('valor_campo')
    if parseFloat($(this).val()) < parseFloat(monto_factura)
      elemento.attr('valor',$(this).val())
      $('#pago_alquiler_detalle_pago_alquilers_attributes_0_monto_fact').val($(this).val())
      calcular_a_pagar(campo)
    else
      if parseFloat($(this).val()) == parseFloat(monto_factura)
        alert('El monto de abono no debe ser igual al total de la factura')
      else
        if parseFloat($(this).val()) > parseFloat(monto_factura)
          alert('El monto de abono no debe ser mayor al de la factura')
      $(this).val($(this).val().substring(0, $(this).val().length-1))
  ".editar_monto_pago input"

calcular_a_pagar = (campo) ->
  suma = parseFloat(0)

  for element, index in $('.monto_pago')
    valor = $("#"+element.id).attr('valor')
    $('#pago_alquiler_detalle_pago_alquilers_attributes_'+index+'_monto_fact').val(valor)
    if valor != ''
      suma += parseFloat(valor)
  $("#total_a_pagar").val(suma)
  monto = $("#total_a_pagar").number(true,2,',','.')
  $("#total_a_pagar").number(monto.val(),2,',','.')
  $("#monto_transferido").val(suma)
  $("#monto_cheque").val(suma)
  $('#form_registro_pago_cheque').data('bootstrapValidator').updateStatus('monto_campo', 'VALID', null);
  $('#form_registro_pago_transferencia').data('bootstrapValidator').updateStatus('monto_campo', 'VALID', null);
  #$('#form_registro_pago_cheque').bootstrapValidator('removeField', 'monto_campo');
  if monto.val() > 0
    $("#btn_guardar").prop('disabled',false)

  $("#pago_alquiler_monto").val(suma)

$("#form_registro_pago_cheque").on
  change:->
    $('.tbody_facturas_pendientes').empty()
    id = $('.tabla_fact_tienda').val()
    $.ajax
      type: "POST"
      #url: "/dynamic_pago_alquilers/mf_facturas_tiendas"
      url: "/pago_alquilers/facturas_tiendas"
      dataType: "HTML"
      data:
        tienda_id: id
      before_send: $.blockUI({message: 'Por favor espere...'})
      success: (data) ->
        html = $('#wrapper')
        html.empty()
        html.append(data)
      error: (data)->
        console.log(data)
      complete: ->
        $.unblockUI()
  ".tabla_fact_tienda"
