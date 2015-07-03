# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require bootstrapValidator/bootstrapValidator
jQuery(document).ready ->

  $('#form_cliente').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "cliente[mall_id]":
        validators:
          notEmpty:
            message: "Debe seleccionar el Mall, campo Obligatorio"
      "cliente[tipo_servicio_id]":
        validators:
          notEmpty:
            message: "Debe seleccionar el tipo de Servicio, campo Obligatorio"
      "cliente[nombre]":
        validators:
          notEmpty:
            message: "Nombre de la empresa es Obligatorio"
      "cliente[RIF]":
        validators:
          notEmpty:
            message: "RIF de la empresa es Obligatorio"
      "cliente[direccion]":
        validators:
          notEmpty:
            message: "Dirección de la empresa es Obligatorio"
      "cliente[telefono]":
        validators:
          notEmpty:
            message: "Teléfono de la empresa es Obligatorio"
      "cliente[nombre_rl]":
        validators:
          notEmpty:
            message: "Nombre del representante legal es Obligatorio"
      "cliente[cedula_rl]":
        validators:
          notEmpty:
            message: "Cédula del representante legal es Obligatorio"
      "cliente[email_rl]":
        validators:
          notEmpty:
            message: "Email del representante legal es Obligatorio"
      "cliente[telefono_rl]":
        validators:
          notEmpty:
            message: "Teléfono del representante legal es Obligatorio"
      "cliente[profesion_rl]":
        validators:
          notEmpty:
            message: "Profesion del representante legal es Obligatorio"
      "cliente[nombre_contacto]":
        validators:
          notEmpty:
            message: "Nombre de la persona de contacto es Obligatorio"
      "cliente[cedula_contacto]":
        validators:
          notEmpty:
            message: "Cédula de la persona de contacto es Obligatorio"
      "cliente[email_contacto]":
        validators:
          notEmpty:
            message: "Email de la persona de contacto es Obligatorio"
      "cliente[telefono_contacto]":
        validators:
          notEmpty:
            message: "Teléfono de la persona de contacto es Obligatorio"
      "cliente[profesion_contacto]":
        validators:
          notEmpty:
            message: "Profesion de la persona de contacto es Obligatorio"
#      "cliente[registro_mercantil]":
#        validators:
#          notEmpty:
#            message: "Inscripción en el Registro Mercantil del representante legal es Obligatorio"


