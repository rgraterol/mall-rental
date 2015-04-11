#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->

  $('#form_registro_user').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "user[name]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre'
      "user[username]":
        validators:
          notEmpty:
            message: 'Debe ingresar un login'
      "user[password]":
        validators:
          notEmpty:
            message: 'Debe ingresar una contraseña'
          regexp:
            regexp: /^(.{8,})$/
            message: 'Contraseña mínima es de 8 carácteres'
      "user[password_confirmation]":
        validators:
          notEmpty:
            message: 'Debe ingresar un valor'
          identical:
            field: 'user[password]'
            message: 'Las contraseñas no coinciden'
      "user[email]":
        validators:
          notEmpty:
            message: 'Debe ingresar el correo eléctronico del usuario.'
      "user[cellphone]":
        validators:
          notEmpty:
            message: 'Debe ingresar un número telefónico.'
      "user[mall_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un mall.'
      "user[role_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un rol.'


  $('#form_edit_user').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "user[name]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre'
      "user[username]":
        validators:
          notEmpty:
            message: 'Debe ingresar un login'
      "user[email]":
        validators:
          notEmpty:
            message: 'Debe ingresar el correo eléctronico del usuario.'
      "user[cellphone]":
        validators:
          notEmpty:
            message: 'Debe ingresar un número telefónico.'
      "user[mall_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un mall.'
      "user[role_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un rol.'

  $('#edit_password_profile').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "user[current_password]":
        validators:
          notEmpty:
            message: 'La contraseña actual es obligatoria'
      "user[password]":
        validators:
          notEmpty:
            message: 'La nueva contraseña es obligatoria'
          regexp:
            regexp: /^(.{8,})$/
            message: 'Contraseña mínima es de 8 carácteres'
      "user[password_confirmation]":
        validators:
          identical:
            field: 'user[password]'
            message: 'Las contraseñas no coinciden'