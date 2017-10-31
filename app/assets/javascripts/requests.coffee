personID = null
$(document).on 'turbolinks:load', ->
    $('#addRequest').hide()
    $('#seachPpl').on 'click', ->
        $.ajax
            type:'GET'
            url: '/requests/showmodal'
            data:
                key:'person'
                val:$('input#name').val()
            success: (response) ->
                $("#modal-window").html(response)
                $('#modal-window').modal('show')
                $('.selNamebtn').on 'click', ->
                    $row = $(this).closest('tr')
                    personID = $row.find('td').first().text()
                    $('#dudename').html('<br><div class="alert alert-dismissible alert-info">'+
                     '<strong>Solicitud para: </strong><a href="'+'/people/'+personID+'" class="alert-link">'+$row.find('td').eq(1).text()+'</a></div>')
                    $('#modal-window').modal('hide')
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
                    $("#modal-window2").html(response)
                    $('#modal-window2').modal('show')
                error: (response) ->
                    alert response
    $('#living_place_wall_material').on 'change', ->
        if $('#living_place_wall_material').val() == 'AGREGAR'
            $.ajax
                type:'GET'
                url: '/requests/showmodal'
                data:
                    key:'wall'
                success: (response) ->
                    $("#modal-window2").html(response)
                    $('#modal-window2').modal('show')
                error: (response) ->
                    alert response
    $('#living_place_roof_material').on 'change', ->
        if $('#living_place_roof_material').val() == 'AGREGAR'
            $.ajax
                type:'GET'
                url: '/requests/showmodal'
                data:
                    key:'roof'
                success: (response) ->
                    $("#modal-window2").html(response)
                    $('#modal-window2').modal('show')
                error: (response) ->
                    alert response
    $('#living_place_floor_material').on 'change', ->
        if $('#living_place_floor_material').val() == 'AGREGAR'
            $.ajax
                type:'GET'
                url: '/requests/showmodal'
                data:
                    key:'floor'
                success: (response) ->
                    $("#modal-window2").html(response)
                    $('#modal-window2').modal('show')
                error: (response) ->
                    alert response
    $('#modal-window2').on 'hidden.bs.modal', ->
        if $('h4').text() == 'AGREGAR OTRO TIPO DE VIVIENDA'
            $('#living_place_kind').prepend('<option value="'+$('#textinput').val()+'">'+$('#textinput').val()+'</option>')
            $('#living_place_kind').val($('#textinput').val())
        else if $('h4').text() == 'AGREGAR OTRO MATERIAL DE PARED'
            $('#living_place_wall_material').prepend('<option value="'+$('#wall').val()+'">'+$('#wall').val()+'</option>')
            $('#living_place_wall_material').val($('#wall').val())
        else if $('h4').text() == 'AGREGAR OTRO MATERIAL DE TECHO'
            $('#living_place_roof_material').prepend('<option value="'+$('#roof').val()+'">'+$('#roof').val()+'</option>')
            $('#living_place_roof_material').val($('#roof').val())
        else if $('h4').text() == 'AGREGAR OTRO MATERIAL DE PISO'
            $('#living_place_floor_material').prepend('<option value="'+$('#floor').val()+'">'+$('#floor').val()+'</option>')
            $('#living_place_floor_material').val($('#floor').val())
        else if $('h4').text() == 'SELECCIONAR PERSONA(S)'
            console.log 'tet'
# $(document).on 'change', '#person_kind', ->
#     unless $(this).val()=='1'
#         $('#person_relationship').prop('disabled',false)
#         console.log $(this).val()
#     else
#         $('#person_relationship').prop('disabled',true)
#         console.log $(this).val()