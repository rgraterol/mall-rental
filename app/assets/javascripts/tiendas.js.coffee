#= require jasny/jasny-bootstrap.min
#= require dataTables/jquery.dataTables.js
#= require dataTables/dataTables.bootstrap.js
#= require dataTables/dataTables.responsive.js
#= require dataTables/dataTables.tableTools.min.js
#= require jqGrid/i18n/grid.locale-el.js
#= require jqGrid/jquery.jqGrid.min.js
#= require jquery-ui/jquery-ui.min.js
#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ($) ->

  $('#form_tiendas').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "tienda[local_id]":
        validators:
          notEmpty:
            message: "Local es Obligatorio"
      "tienda[arrendatario_id]":
        validators:
          notEmpty:
            message: "Arrendatario es Obligatorio"
      "tienda[actividad_economica_id]":
        validators:
          notEmpty:
            message: "Actividad Económica es Obligatoria"
      tipo_canon_alquiler_required:
        selector: '.tipo_canon_alquiler_required'
        validators:
          notEmpty:
            message: "Tipo Canon Alquiler es Obligatorio"
      canon_fijo_ml:
        selector: '.canon_fijo_ml'
        validators:
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: 'Canón Fijo en Bs. obligatorio para tipo Canón Fijo'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'canon_fijo' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true
      canon_fijo_usd:
        selector: '.canon_fijo_usd'
        validators:
          numeric:
              message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: 'Canón Fijo en $. obligatorio para tipo Canón Fijo'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'canon_fijo' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true
      porc_canon_ventas:
        selector: '.porc_canon_ventas'
        validators:
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: '% Canón por Ventas obligatorio para tipo de canón Porcentaje de Ventas'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'porcentaje_de_ventas' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true
      monto_minimo_ventas:
        selector: '.monto_minimo_ventas'
        validators:
          numeric:
            message: 'Debe ser un valor numerico, decimales separados por punto'
          callback:
            message: 'Monto Mínimo de Ventas Mensual obligatorio para tipo de canón Porcentaje de Ventas'
            callback: (value, validator, $field) ->
              canon = $('#select_canon_alquiler').val()
              if (canon == 'porcentaje_de_ventas' or canon == 'canon_fijo_y_porcentaje_ventas') and value == ''
                false
              else
                true




  $('#add_actividad_economica_select').hide()
  $('#validacion_nombre_actividad').hide()
  $('#validacion_nombre_en_uso_actividad').hide()
  $('#loading_actividad_economica').hide()

  $('#select_actividad_economica_tienda').change ->
    $('#validacion_nombre_en_uso_actividad').hide()
    $('#validacion_nombre_actividad').hide()
    if $(this).val() == 'nueva_actividad_economica'
      $('#add_actividad_economica_select').show()
    else
      $('#add_actividad_economica_select').hide()


  $('#tienda_arrendatario_id').change ->
    if $('#tienda_nombre').val() == '' && $(this).val() != ''
      $('#tienda_nombre').val($('#tienda_arrendatario_id option:selected').text())

  $('#agregar_actividad_economica_tienda').click ->
    if $('#nueva_actividad_economica').val() == ''
      $('#validacion_nombre_actividad').show()
    else
      $('#loading_actividad_economica').show()
      $.ajax
        type: "POST"
        url: "/dynamic_add_actividad/actividad"
        dataType: "JSON"
        data:
          nombre: $('#nueva_actividad_economica').val()
        success: (data) ->
          $('#validacion_nombre_en_uso_actividad').hide()
          $('#select_actividad_economica_tienda')
          .append($('<option>', { value : data.id })
            .text(data.nombre));
          $("#select_actividad_economica_tienda").val(data.id);
          $('#add_actividad_economica_select').hide()
          $('#nueva_actividad_economica').val('')
        error: (data)->
          $('#validacion_nombre_en_uso_actividad').show()
        complete: ->
          $('#loading_actividad_economica').hide()

  $('#select_canon_alquiler').change ->
    if $(this).val() == 'canon_fijo'
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').hide()
      $('#canon_porcentaje').find(':input').prop('disabled', true);
    else if $(this).val() == 'canon_fijo_y_porcentaje_ventas'
      $('#canon_fijo').show()
      $('#canon_fijo').find(':input').prop('disabled', false);
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
    else if $(this).val() == 'porcentaje_de_ventas'
      $('#canon_fijo').hide()
      $('#canon_fijo').find(':input').prop('disabled', true);
      $('#canon_porcentaje').show()
      $('#canon_porcentaje').find(':input').prop('disabled', false);
    else
      $('#canon_fijo').hide()
      $('#canon_fijo').find(':input').prop('disabled', true);
      $('#canon_porcentaje').hide()
      $('#canon_porcentaje').find(':input').prop('disabled', true);


#  $('#table_tiendas_index').dataTable
#    'dom': 'T<"clear">lfrtip'
#    'tableTools':
#      'sSwfPath': '../assets/dataTables/swf/copy_csv_xls_pdf.swf'
#      "aButtons": [
#        {
#          "sExtends":     "copy",
#          "sButtonText": "Copiar"
#        },
#        {
#          "sExtends":     "csv",
#          "sButtonText": "Excel"
#        },
#        {
#          "sExtends":     "pdf",
#          "sButtonText": "PDF"
#        },
#        {
#          "sExtends":     "print",
#          "sButtonText": "Imprimir"
#        },
#      ]
#    "language": {
#      "sProcessing":    "Procesando...",
#      "sLengthMenu":    "Mostrar _MENU_ Registros",
#      "sZeroRecords":   "No se encontraron resultados",
#      "sEmptyTable":    "Ningún dato disponible en esta tabla",
#      "sInfo":          "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
#      "sInfoEmpty":     "Mostrando registros del 0 al 0 de un total de 0 registros",
#      "sInfoFiltered":  "(filtrado de un total de _MAX_ registros)",
#      "sInfoPostFix":   "",
#      "sSearch":        "Buscar: ",
#      "sUrl":           "",
#      "sInfoThousands":  ",",
#      "sLoadingRecords": "Cargando...",
#      "oPaginate": {
#        "sFirst":    "Primero",
#        "sLast":    "Último",
#        "sNext":    "Siguiente",
#        "sPrevious": "Anterior"
#      },
#      "oAria": {
#        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
#        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
#      }
#    }

  $('.tienda-filter').change ->
    $('#div_table_tiendas_index').empty()
    $('#loading_table_index').show()
    $.ajax
      type: "POST"
      url: "/tiendas/mf_dynamic_filter/"
      dataType: "HTML"
      data:
        nivel_mall_id: $('#nivel_mall_select_tiendas').val()
        actividad_economica_id: $('#actividad_economica_select_tiendas').val()
        vencido: $('#contratos_select_tiendas').val()
      success: (data) ->
        html = $('#div_table_tiendas_index')
        html.empty()
        html.append(data)
        $('#loading_table_index').hide()
      complete: ->
        $('#loading_table_index').hide()


  $(document).on "page:update", ->
    $('#table_tiendas_index').dataTable
      'dom': 'T<"clear">lfrtip'
      'tableTools':
        'sSwfPath': '../assets/dataTables/swf/copy_csv_xls_pdf.swf'
        "aButtons": [
          {
            "sExtends":     "copy",
            "sButtonText": "Copiar"
          },
          {
            "sExtends":     "csv",
            "sButtonText": "Excel"
          },
          {
            "sExtends":     "pdf",
            "sButtonText": "PDF"
          },
          {
            "sExtends":     "print",
            "sButtonText": "Imprimir"
          },
        ]
      "language": {
        "sProcessing":    "Procesando...",
        "sLengthMenu":    "Mostrar _MENU_ Registros",
        "sZeroRecords":   "No se encontraron resultados",
        "sEmptyTable":    "Ningún dato disponible en esta tabla",
        "sInfo":          "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
        "sInfoEmpty":     "Mostrando registros del 0 al 0 de un total de 0 registros",
        "sInfoFiltered":  "(filtrado de un total de _MAX_ registros)",
        "sInfoPostFix":   "",
        "sSearch":        "Buscar: ",
        "sUrl":           "",
        "sInfoThousands":  ",",
        "sLoadingRecords": "Cargando...",
        "oPaginate": {
          "sFirst":    "Primero",
          "sLast":    "Último",
          "sNext":    "Siguiente",
          "sPrevious": "Anterior"
        },
        "oAria": {
          "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
          "sSortDescending": ": Activar para ordenar la columna de manera descendente"
        }
      }
