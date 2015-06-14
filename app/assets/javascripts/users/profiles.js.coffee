#= require jasny/jasny-bootstrap.min
#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->
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
             message: "Nombre de Usuario es Obligatorio"
       "user[username]":
         validators:
           notEmpty:
             message: "Login es Obligatorio"
       "user[email]":
         validators:
           notEmpty:
             message: "Email es Obligatorio"