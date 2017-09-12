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
                
    $('#addBenefit').on 'click', ->
        $.ajax
            type:'GET'
            url: '/requests/showmodal'
            data:
                key:'benefit'
            success: (response) ->
                $("#modal-window").html(response)
                $('#modal-window').modal('show')
            error: (response) ->
                alert response
                
    $('#addService').on 'click', ->
        $.ajax
            type:'GET'
            url: '/requests/showmodal'
            data:
                key:'service'
            success: (response) ->
                $("#modal-window").html(response)
                $('#modal-window').modal('show')
            error: (response) ->
                alert response
                
    $('#living_place_kind').on 'change', ->
        if $('#living_place_kind').val() == 'OTROS'
            $.ajax
                type:'GET'
                url: '/requests/showmodal'
                data:
                    key:'kind'
                success: (response) ->
                    $("#modal-window").html(response)
                    $('#modal-window').modal('show')
                error: (response) ->
                    alert response
    $('#modal-window').on 'hidden.bs.modal', ->
        console.log $('#textinput').val()
        $('#living_place_kind').prepend('<option value="'+$('#textinput').val()+'">'+$('#textinput').val()+'</option>')
        $('#living_place_kind').val($('#textinput').val())