# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(document).on 'click', '#add_member', (e) ->
    $('#link').hide()
    $('#form').show()
    return

  $(document).on 'click', '#add_member_cancel', (e) ->
    $('#link').show()
    $('#form').hide()
    $('#email').val(null)
    $('#info_message').hide()
    return
  return

