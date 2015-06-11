#= require dataTables/jquery.dataTables.js
#= require dataTables/dataTables.bootstrap.js
#= require dataTables/dataTables.responsive.js
#= require dataTables/dataTables.tableTools.min.js
#= require jqGrid/i18n/grid.locale-el.js
#= require jqGrid/jquery.jqGrid.min.js
#= require jquery-ui/jquery-ui.min.js
#= require bootstrapValidator/bootstrapValidator
jQuery(document).ready ->

  $('#form_arrendatarios').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "arrendatario[nombre]":
        validators:
          notEmpty:
            message: "Nombre de la empresa es Obligatorio"
      "arrendatario[rif]":
        validators:
          notEmpty:
            message: "RIF de la empresa es Obligatorio"
      "arrendatario[direccion]":
        validators:
          notEmpty:
            message: "Dirección de la empresa es Obligatorio"
      "arrendatario[telefono]":
        validators:
          notEmpty:
            message: "Teléfono de la empresa es Obligatorio"
      "arrendatario[nombre_rl]":
        validators:
          notEmpty:
            message: "Nombre del representante legal es Obligatorio"
      "arrendatario[cedula_rl]":
        validators:
          notEmpty:
            message: "Cédula del representante legal es Obligatorio"
      "arrendatario[email_rl]":
        validators:
          notEmpty:
            message: "Email del representante legal es Obligatorio"
      "arrendatario[telefono_rl]":
        validators:
          notEmpty:
            message: "Teléfono del representante legal es Obligatorio"
      "arrendatario[registro_mercantil]":
        validators:
          notEmpty:
            message: "Inscripción en el Registro Mercantil del representante legal es Obligatorio"


  $('#table_inquilinos_index').dataTable
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