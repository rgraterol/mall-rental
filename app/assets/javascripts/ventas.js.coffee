# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).ready ($) ->
  $(".actualizar_ventas").change()
  $(".actualizar_auditoria_ventas").change()
  $(".actualizar_ventas_mes").change()
  ###now = new Date()
  anio_hoy = now.getFullYear()
  mes_hoy = now.getMonth().to_s

  if ($("#date_lapso_year").val()).to_s == anio_hoy.to_s
    alert(mes_hoy)###

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
      #$('#validacion_nombre_en_uso_actividad').show()
    complete: ->
      a=1
      #$('# loading_actividad_economica').hide()

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
          #$('#validacion_nombre_en_uso_actividad').show()
          complete: ->
            a=1
            #$('# loading_actividad_economica').hide()
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
    success: (data) ->

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

        $("#tbody_auditoria_ventas").append("<tr><td>"+element.tienda+"</td><td>"+element.actividad_economica+"</td>" +
                                                "<td>"+element.local+"</td>" +
                                                "<td>"+element.tipo_canon+"</td><td>"+element.canon_fijo+"</td>" +
                                                "<td>"+element.ventas_mes+"</td><td>"+element.canon_x_ventas+"</td>" +
                                                "<td>"+element.total_canon+"</td>" +
                                                "<td><input type='checkbox' disabled='disabled' "+@cadena_check+" /></td>" +
                                                "<td><input type='checkbox' name='recibo_cobro' disabled='disabled' "+@cadena_recibo+" /></td>" +
                                                "<td><a href='/ventas_tiendas/"+element.tienda_id+"'>Ver Ventas diarias</a></td></tr>")

        $("#tbody_mall_ventas").append("<tr><td>"+element.tienda+"</td><td>"+element.actividad_economica+"</td>" +
                                          "<td>"+element.local+"</td><td>"+element.nivel_ubicacion+"</td>" +
                                          "<td>"+element.tipo_canon+"</td><td>"+element.canon_fijo+"</td>" +
                                          "<td>"+element.ventas_mes+"</td><td>"+element.canon_x_ventas+"</td>" +
                                          "<td>"+element.total_canon+"</td>" +
                                          "<td><a href='/ventas_tiendas/"+element.tienda_id+"'>Ver Ventas diarias</a></td></tr>")


    error: (data)->
      console.log(data)
  #$('#validacion_nombre_en_uso_actividad').show()
    complete: ->
      a=1
$(".actualizar_ventas_mes").on "change", ->
  $.ajax
    type: "POST"
    url: "/dynamic_ventas_mes/ventas"
    dataType: "JSON"
    data:
      year: $("#date_lapso_year").val()
    success: (data) ->
      console.log(data[0]['ventas'][0].ventas)

      $("#tbody-ventas-mall").empty()
      $("#tbody-ventas-mall").append("<tr><th>Enero</th><td>"+data[0]['ventas'][0].ventas+"</td><td>"+data[0]['ventas'][0].canon_fijo+"</td><td>"+data[0]['ventas'][0].canon_x_ventas+"</td><td>"+data[0]['ventas'][0].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Febrero</th><td>"+data[0]['ventas'][1].ventas+"</td><td>"+data[0]['ventas'][1].canon_fijo+"</td><td>"+data[0]['ventas'][1].canon_x_ventas+"</td><td>"+data[0]['ventas'][1].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Marzo</th><td>"+data[0]['ventas'][2].ventas+"</td><td>"+data[0]['ventas'][2].canon_fijo+"</td><td>"+data[0]['ventas'][2].canon_x_ventas+"</td><td>"+data[0]['ventas'][2].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Abril</th><td>"+data[0]['ventas'][3].ventas+"</td><td>"+data[0]['ventas'][3].canon_fijo+"</td><td>"+data[0]['ventas'][3].canon_x_ventas+"</td><td>"+data[0]['ventas'][3].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Mayo</th><td>"+data[0]['ventas'][4].ventas+"</td><td>"+data[0]['ventas'][4].canon_fijo+"</td><td>"+data[0]['ventas'][4].canon_x_ventas+"</td><td>"+data[0]['ventas'][4].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Junio</th><td>"+data[0]['ventas'][5].ventas+"</td><td>"+data[0]['ventas'][5].canon_fijo+"</td><td>"+data[0]['ventas'][5].canon_x_ventas+"</td><td>"+data[0]['ventas'][5].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Julio</th><td>"+data[0]['ventas'][6].ventas+"</td><td>"+data[0]['ventas'][6].canon_fijo+"</td><td>"+data[0]['ventas'][6].canon_x_ventas+"</td><td>"+data[0]['ventas'][6].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Agosto</th><td>"+data[0]['ventas'][7].ventas+"</td><td>"+data[0]['ventas'][7].canon_fijo+"</td><td>"+data[0]['ventas'][7].canon_x_ventas+"</td><td>"+data[0]['ventas'][7].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Septiembre</th><td>"+data[0]['ventas'][8].ventas+"</td><td>"+data[0]['ventas'][8].canon_fijo+"</td><td>"+data[0]['ventas'][8].canon_x_ventas+"</td><td>"+data[0]['ventas'][8].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Octubre</th><td>"+data[0]['ventas'][9].ventas+"</td><td>"+data[0]['ventas'][9].canon_fijo+"</td><td>"+data[0]['ventas'][9].canon_x_ventas+"</td><td>"+data[0]['ventas'][9].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Noviembre</th><td>"+data[0]['ventas'][10].ventas+"</td><td>"+data[0]['ventas'][10].canon_fijo+"</td><td>"+data[0]['ventas'][10].canon_x_ventas+"</td><td>"+data[0]['ventas'][10].total_mes_canon+"</td></tr>")
      $("#tbody-ventas-mall").append("<tr><th>Diciembre</th><td>"+data[0]['ventas'][11].ventas+"</td><td>"+data[0]['ventas'][11].canon_fijo+"</td><td>"+data[0]['ventas'][11].canon_x_ventas+"</td><td>"+data[0]['ventas'][11].total_mes_canon+"</td></tr>")
      $("#suma_total").text(data[0]['suma_total'])
      $("#total_canon_fijo").text(data[0]['total_canon_fijo'])
      $("#total_canon_x_ventas").text(data[0]['total_canon_x_ventas'])
      $("#total_canons").text(data[0]['total_canons'])

    error: (data)->
      console.log(data)
  #$('#validacion_nombre_en_uso_actividad').show()
    complete: ->
      a=1



