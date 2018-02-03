$(document).on "turbolinks:load", ->
    pattern = /Agregar Parientes a/i
    $('#addRelative').hide() if $('h1').text().match(pattern)