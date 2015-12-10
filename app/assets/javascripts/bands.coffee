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

  $(document).on 'click', '#add_member_save', (e) ->
    band_id = $('#band_id').val()
    email   = $('#email').val()
    url     = "/minhas-bandas/#{band_id}/convidar-membros"

    $.ajax
      url     : url
      type    : 'POST'
      data    : {email:email}
      success : (data) ->
        if data.status
          item  = "<li id=\"member_#{data.user.id}\">#{data.user.name}</li>"
          $('ul#current_items').append(item)
          $('#email').val(null)
          $('#form').hide()

          console.log data.user.name
        else
          $('#info_message').html(data.message)
          $('#info_message').show()
        return
    return

  $(document).on 'click', '.remove_member', (e) ->
    if !confirm('Está certo disso?')
      return

    $this   = $(this)
    band_id = $('#band_id').val()
    user_id = $this.attr('id').match(/link_remove_(\d+)/)[1]
    url     = "/minhas-bandas/#{band_id}/remover-membro/#{user_id}"

    $.ajax
      url     : url
      type    : 'DELETE'
      success : (data) ->
        if data.status
          $("#member_#{data.user_id}").remove()
        else
          $('#info_message').html(data.message)
          $('#info_message').show()
        return
    return
  return
