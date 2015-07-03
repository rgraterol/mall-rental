#= require hashtable
#= require jquery.numberformatter-1.2.4

jQuery(document).ready ->
  $('.numeric').blur ->
    $(this).parseNumber({format:"#,###.00", locale:"us"});
    $(this).formatNumber({format:"#,###.00", locale:"us"})