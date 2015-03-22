jQuery(document).ready ->

  $('#form_registro_user').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "user[username]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre de usuario'
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

  $('#form_edit_user').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "user[password]":
        validators:
          regexp:
            regexp: /^(.{8,})$/
            message: 'Contraseña mínima es de 8 carácteres'
      "user[password_confirmation]":
        validators:
          identical:
            field: 'user[password]'
            message: 'Las contraseñas no coinciden'

  $('#edit_password_profile').bootstrapValidator
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