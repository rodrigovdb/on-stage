# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.button-collapse').sideNav()

  $('select').material_select()

  $('.datepicker').pickadate
    selectMonths: true
    selectYears: 15

  return
