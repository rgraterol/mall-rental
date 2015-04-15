# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->
  current_mes = $("#ventas_select_month option:selected").val()

  $("#ventas_select_month").each(
      alert(this.val())
  )