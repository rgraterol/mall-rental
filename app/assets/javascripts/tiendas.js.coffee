jQuery(document).ready ($) ->

  $('#add_actividad_economica_select').hide()
  $('#validacion_nombre_actividad').hide()
  $('#validacion_nombre_en_uso_actividad').hide()

  $('#select_actividad_economica_tienda').change ->
    if $(this).val() == 'nueva_actividad_economica'
      $('#add_actividad_economica_select').show()
    else
      $('#add_actividad_economica_select').hide()

  $('#agregar_actividad_economica_tienda').click ->
    if $('#nueva_actividad_economica').val() == ''
      $('#validacion_nombre_actividad').show()
    else
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
