# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jquery.blockUI.js
jQuery(document).ready ($) ->
  $(".actualizar_ventas").change()
  $(".actualizar_auditoria_ventas").change()
  $(".actualizar_ventas_mes").change()

$(".actualizar_ventas").on "change", ->
  $.ajax
    type: "POST"
    url: "/dynamic_venta_diaria/venta"
    dataType: "JSON"
    data:
      year: $("#date_lapso_year").val()
      month: $("#ventas_select_month").val()
      tienda_id: $("#tienda_id").val()
    success: (data) ->
      $("#total_ventas").val(data[0]['suma'])
      $("#tbody_ventas").empty()
      for element, index in data[0]['ventas']
        @editable = element.editable
        if @editable
          @clase = 'editar_monto_venta'
          @title = 'Editar Monto'
        else
          @clase = ''
          @title = 'Campo no editable'
        $("#tbody_ventas").append("<tr><td>"+element.fecha+"</td><td id='mount_"+element.id+"' class='"+@clase+"' title='"+@title+"' fecha='"+element.fecha+"' campo='"+element.id+"'>"+element.monto+"</td></tr>")
    error: (data)->
      console.log(data)
    complete: ->
      a=1

$("#tbody_ventas").on
  click:->
    if $('input',this).length == 0
      valor = $(this).text()
      fecha = $(this).attr('fecha')
      id = $(this).attr('campo')
      $(this).text('')
      $(this).append("<input type='text' value='"+valor+"' valor='"+valor+"' codigo='"+fecha+"' campo='"+id+"'></input>")
      $('input',this).focus()
  ".editar_monto_venta"

$("#tbody_ventas").on
  blur:->
    valor = $(this).attr('valor')
    if ($(this).val() != '')
      if confirm('¿Guardar monto?')
        $.ajax
          type: "POST"
          url: "/dynamic_venta_diaria/guardar_ventas"
          dataType: "JSON"
          data:
            valor: $(this).val()
            codigo: $(this).attr('codigo')
            id: $(this).attr('campo')
            tienda_id: $("#tienda_id").val()
          success: (data) ->
            if(data[0]['result'])
              $(".actualizar_ventas").change()
            else
              alert('No guardo')
          error: (data)->
            console.log(data)
          complete: ->
            a=1
        $(this).parent().text($(this).val())
        $(this).remove()
      else
        $(this).parent().text(valor)
        $(this).remove()
    else
      $(this).parent().text($(this).val())
      $(this).remove()
  ".editar_monto_venta input"

$(".actualizar_auditoria_ventas").on "change", ->
  $.ajax
    type: "POST"
    url: "/dynamic_venta_auditoria/auditoria"
    dataType: "JSON"
    data:
      year: $("#date_lapso_year").val()
      month: $("#ventas_select_month").val()
    before_send: $.blockUI({message: 'Por favor espere...'})
    success: (data) ->
      console.log(data[0]['tiendas_cont'])
      $("#total_ventas_mes").val(data[0]['total_ventas'])
      $("#monto_canon_fijo").val(data[0]['suma_canon_fijo'])
      $("#monto_canon_x_venta").val(data[0]['suma_canon_ventas'])
      $("#total_canon").val(data[0]['total'])

      $("#tbody_auditoria_ventas").empty()
      $("#tbody_mall_ventas").empty()
      for element, index in data[0]['tiendas']
        @cadena_check = "title='Falta Registrar Ventas'"
        @cadena_recibo =  "title='Falta Enviarle Recibo de Cobro'"
        if element.actualizada
          @cadena_check = "checked title='Ventas Actualizadas'"
        if element.recibos_cobro
          @cadena_recibo = "checked title='Recibo Cobro Enviado'"

        $("#tbody_auditoria_ventas").append("<tr><td>"+element.tienda+"</td><td>"+element.actividad_economica+"</td>" +
                                                "<td>"+element.local+"</td>" +
                                                "<td>"+element.tipo_canon+"</td><td>"+element.canon_fijo+"</td>" +
                                                "<td>"+element.ventas_mes+"</td><td>"+element.canon_x_ventas+"</td>" +
                                                "<td>"+element.total_canon+"</td>" +
                                                "<td><input type='checkbox' disabled='disabled' name='ventas_actualizadas' value='"+element.tienda_id+"' "+@cadena_check+" /></td>" +
                                                "<td><input type='checkbox' name='recibo_cobro_"+element.tienda_id+"' disabled='disabled' "+@cadena_recibo+" /></td>" +
                                                "<td><a href='/ventas_tiendas/"+element.tienda_id+"'>Ver Ventas diarias</a></td></tr>")

        $("#tbody_mall_ventas").append("<tr><td>"+element.tienda+"</td><td>"+element.actividad_economica+"</td>" +
                                          "<td>"+element.local+"</td><td>"+element.nivel_ubicacion+"</td>" +
                                          "<td>"+element.tipo_canon+"</td><td>"+element.canon_fijo+"</td>" +
                                          "<td>"+element.ventas_mes+"</td><td>"+element.canon_x_ventas+"</td>" +
                                          "<td>"+element.total_canon+"</td>" +
                                          "<td><a href='/ventas_tiendas/"+element.tienda_id+"'>Ver Ventas diarias</a></td></tr>")

    error: (data)->
      console.log(data)
    complete: ->
      $.unblockUI()
$(".actualizar_ventas_mes").on "change", ->
  $.ajax
    type: "POST"
    url: "/dynamic_ventas_mes/ventas"
    dataType: "JSON"
    data:
      year: $("#date_lapso_year").val()
    success: (data) ->
      $("#tbody-ventas-mall").empty()
      meses = ['Enero', 'Febrero', 'Marzo', 'Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']
      mes_fin = data[0]['mes_actual']-1

      for num in [0..mes_fin]
        $("#tbody-ventas-mall").append("<tr><th>"+meses[num]+"</th><td>"+data[0]['ventas'][num].ventas+"</td><td>"+data[0]['ventas'][num].canon_fijo+"</td><td>"+data[0]['ventas'][num].canon_x_ventas+"</td><td>"+data[0]['ventas'][num].total_mes_canon+"</td></tr>")

      $("#suma_total").text(data[0]['suma_total'])
      $("#total_canon_fijo").text(data[0]['total_canon_fijo'])
      $("#total_canon_x_ventas").text(data[0]['total_canon_x_ventas'])
      $("#total_canons").text(data[0]['total_canons'])

    error: (data)->
      console.log(data)
    complete: ->
      a=1

$("#btn-send-recibos").on "click", ->
  now = new Date()
  anio_hoy = now.getFullYear()
  mes_hoy = now.getMonth()+1

  year = $("#date_lapso_year option:selected").val()
  month = $("#ventas_select_month option:selected").val()
  if ((String(year) == String(anio_hoy)) and (String(month) == String(mes_hoy)))
    $.blockUI({
      message: 'Esta opcion es valida solo para meses anteriores',
    });
    $('.blockOverlay').attr('title','Click para cerrar').click($.unblockUI);
  else
    sel_actualizada = $('input[name=ventas_actualizadas]:checked')

    if (sel_actualizada.length > 0)
      tiendas = new Array()
      notificar = new Array()
      for element, index in sel_actualizada
        if !$('input[name=recibo_cobro_'+element.value+']').is(':checked')
          tiendas.push(element.value)
      if tiendas.length > 0
        $.ajax
          type: "POST"
          url: "/dynamic_pago_alquilers/recibos_cobro"
          dataType: "JSON"
          async: false
          data:
            year: $("#date_lapso_year").val()
            month: $("#ventas_select_month").val()
            tiendas: tiendas
          success: (data) ->
            if data[0]['result']
              for element, index in data[0]['tiendas']
                $('input[name=recibo_cobro_'+element+']').prop('checked',true)
              $.blockUI({
                message: 'Recibos de Cobro enviados correctamente',
                timeout: 3000,
              });
          error: (data)->
            #$.unblockUI()
            console.log(data)
          complete: ->
            a=1
      else
        $.blockUI({
          message: 'Ya se enviaron los recibos de cobro',
        });
        setTimeout($.unblockUI, 2000);
