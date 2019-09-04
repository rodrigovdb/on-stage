# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.button-collapse').sideNav()

  $('select').material_select()

  $('.modal').modal()

  $('.datepicker').pickadate
    selectMonths: true
    selectYears: 15

  $('#darken_switch').change ->
    $('#darken_form').submit()
    return

  return
