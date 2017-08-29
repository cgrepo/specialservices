$(document).on 'turbolinks:load', ->
    $('#addPerson').on 'click', ->
        $.ajax
            type:'GET'
            url: '/requests/showmodal'
            data:
                key:'person'
            success: (response) ->
                $("#modal-window").html(response)
                $('#modal-window').modal('show')
            error: (response) ->
                alert response
                
    $('#addExpediture').on 'click', ->
        $.ajax
            type:'GET'
            url: '/requests/showmodal'
            data:
                key:'expediture'
            success: (response) ->
                $("#modal-window").html(response)
                $('#modal-window').modal('show')
            error: (response) ->
                alert response