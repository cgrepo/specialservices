personID = null
$(document).on 'turbolinks:load', ->
    #$('#addRequest').hide()
    $('#otherExpedituresTable').hide()
    $('#editPpl').hide()
    $('#seachPpl').on 'click', ->
        unless $('input#name').val() == ''
            spinner('ON')
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
                        $('input#name').attr('disabled',true)
                        $('#seachPpl').fadeToggle('slow')
                        $('#editPpl').fadeToggle('slow')
                        spinner('OFF')
                        fillCase()
                        fillExp()
                error: (response) ->
                    spinner('OFF')
                    alert response
        else
            alert 'proporcionar el nombre a buscar'
    #$(document).on 'submit', 'form#addExpeditureCommit',(e) ->
    #    e.preventDefault()
        
            
        
    $('#modal-window').on 'hidden.bs.modal', ->
       spinner('OFF')
    $('#editPpl').on 'click', ->
        $('input#name').val('')
        $('input#name').attr('disabled',false)
        $('#editPpl').fadeToggle('slow')
        $('#seachPpl').fadeToggle('slow')
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
spinner=(opt) ->
    if opt == 'ON'
        $('#spinnerContainer').spin
            lines: 12
            length: 7
            width: 8
            radius: 6
            color: 'blue'
            # speed: 1
            trail: 60
            shadow: false
    if opt == 'OFF'
        $('#spinnerContainer').spin false
fillCase=->
    $('#request_case').val('889')
    $('#request_rdate').val('11/11/2017')
    $('#request_sent_by').val('NOSFERATUS')
    $('#request_oriented').val('HELL')
    $('#request_service').val('MONEY MAN')
    $('#request_qualification').val('9')
    $('#request_notes').val('HEs LYNING DONT TRUST HIM')
fillExp=->
    $('#expediture_feeding').val('100')
    $('#expediture_rent').val('100')
    $('#expediture_electricity').val('100')
    $('#expediture_water').val('100')
    $('#expediture_fuel').val('100')
    $('#expediture_education').val('100')