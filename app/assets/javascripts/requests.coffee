personID = null
superCell = []
$(document).on 'turbolinks:load', ->
    setup()
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
                        tabsEnabled(true)
                        caseUIEnabled(true)
                error: (response) ->
                    spinner('OFF')
                    alert response
        else
            alert 'proporcionar el nombre a buscar'
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
                $("#modal-window2").html(response)
                $('#modal-window2').modal('show')
            error: (response) ->
                alert response
    $('#addBenefit').on 'click', ->
        $.ajax
            type:'GET'
            url: '/requests/showmodal'
            data:
                key:'benefit'
            success: (response) ->
                $("#modal-window2").html(response)
                $('#modal-window2').modal('show')
            error: (response) ->
                alert response
    $('#addService').on 'click', ->
        $.ajax
            type:'GET'
            url: '/requests/showmodal'
            data:
                key:'service'
            success: (response) ->
                $("#modal-window3").html(response)
                $('#modal-window3').modal('show')
            error: (response) ->
                alert response
    $('#saveService').on 'click', ->
        if $('#other_service_name').val() == ''
            alert 'proporcionar un nombre de servicio'
    $('#saveAll').on 'click', ->
        validate()

    $('#living_place_kind').on 'change', ->
        if $('#living_place_kind').val() == 'OTROS'
            $.ajax
                type:'GET'
                url: '/requests/showmodal'
                data:
                    key:'kind'
                success: (response) ->
                    $("#modal-window3").html(response)
                    $('#modal-window3').modal('show')
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
                    $("#modal-window3").html(response)
                    $('#modal-window3').modal('show')
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
                    $("#modal-window3").html(response)
                    $('#modal-window3').modal('show')
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
                    $("#modal-window3").html(response)
                    $('#modal-window3').modal('show')
                error: (response) ->
                    alert response
                    
    $('#modal-window').on 'hidden.bs.modal', ->
        spinner('OFF')
    $('#modal-window2').on 'show.bs.modal', ->
        $('#new-benefit-name').hide()
        $('#label-new-benefit').hide()
        $('#save-benefit-name').hide()
        $('#benefit_name').on 'change', ->
            if $(this).val() == 'OTRO'
                $('#new-benefit-name').fadeToggle()
                $('#label-new-benefit').fadeToggle()
                $('#save-benefit-name').fadeToggle()
                $('#benefit_amount').attr('disabled',true)
                $('.addBenefit').attr('disabled',true)
                $('#benefit_name').attr('disabled',true)
        $('#save-benefit-name').on 'click', ->
            if $('#new-benefit-name').val() == ''
                alert 'nombre invalido'
            else
                lastValue = $('#new-benefit-name').val()
                $('#benefit_name').append('<option value="'+lastValue+'">'+lastValue+"</option>")
                $('#benefit_name').val(lastValue)
                $('#new-benefit-name').fadeToggle()
                $('#label-new-benefit').fadeToggle()
                $('#save-benefit-name').fadeToggle()
                $('#benefit_amount').attr('disabled',false)
                $('.addBenefit').attr('disabled',false)
                $('#benefit_name').attr('disabled',false)
    $('#modal-window3').on 'hidden.bs.modal', ->
        console.log 'got here'
        console.log $('h4').attr('id')
        if $('h4').attr('id') == 'newKind'
            console.log $('#textinput').val()
            unless $('#textinput').val() == ''
                $('#living_place_kind').append('<option value="'+$('#textinput').val()+'">'+$('#textinput').val()+'</option>')
                $('#living_place_kind').val($('#textinput').val())
            else
                alert 'debe proporcionar un tipo'
        else 
            if $('h4').attr('id') == 'newWall'
                unless $('#wall').val() == ''
                    $('#living_place_wall_material').append('<option value="'+$('#wall').val()+'">'+$('#wall').val()+'</option>')
                    $('#living_place_wall_material').val($('#wall').val())
                else
                    alert 'debe proporcionar un material'
            else 
                if $('h4').attr('id') == 'newRoof'
                    unless $('#roof').val() == ''
                        $('#living_place_roof_material').append('<option value="'+$('#roof').val()+'">'+$('#roof').val()+'</option>')
                        $('#living_place_roof_material').val($('#roof').val())
                    else
                        alert 'debe proporcionar un material'
                else 
                    if $('h4').attr('id') == 'newFloor'
                        unless $('#floor').val() == ''
                            $('#living_place_floor_material').append('<option value="'+$('#floor').val()+'">'+$('#floor').val()+'</option>')
                            $('#living_place_floor_material').val($('#floor').val())
                        else
                            alert 'debe proporcionar un material'
    $('#modal-window3').on 'show.bs.modal', ->
        $('.badBoy').keypress (event) ->
            if event.keyCode == 13
                event.preventDefault()
tabsEnabled=(opt) ->
    if opt
        $('.nav li#expedit').removeClass('disabled')
        $('.nav li#expedit').find('a').attr("data-toggle","tab")
        $('.nav li#live').removeClass('disabled')
        $('.nav li#live').find('a').attr("data-toggle","tab")
        $('.nav li#expedit').fadeToggle('slow')
        $('.nav li#live').fadeToggle('slow')
    else
        $('.nav li#expedit').hide()
        $('.nav li#live').hide()
        $('.nav li#expedit').addClass('disabled')
        $('.nav li#expedit').find('a').removeAttr("data-toggle")
        $('.nav li#live').addClass('disabled')
        $('.nav li#live').find('a').removeAttr("data-toggle")
caseUIEnabled=(opt) ->
    if opt
        $('#request_case').attr('disabled',false)
        $('#request_rdate').attr('disabled',false)
        $('#request_sent_by').attr('disabled',false)
        $('#request_oriented').attr('disabled',false)
        $('#request_service').attr('disabled',false)
        $('#request_qualification').attr('disabled',false)
        $('#request_notes').attr('disabled',false)
    else
        $('#request_case').attr('disabled',true)
        $('#request_rdate').attr('disabled',true)
        $('#request_sent_by').attr('disabled',true)
        $('#request_oriented').attr('disabled',true)
        $('#request_service').attr('disabled',true)
        $('#request_qualification').attr('disabled',true)
        $('#request_notes').attr('disabled',true)
        
setup=->
    tabsEnabled(false)
    $('#editPpl').hide()
    caseUIEnabled(false)
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
validate=->
    requestDataFlag = false
    console.log $('#request_case').val()
    unless $('#request_case').val() == ''
        superCell[0] =  $('#request_case').val()
    else
        requestDataFlag = true
        $('#request_case').css('color','red')
        $('#request_case').val('¿ NO DATA ?') 
    
    unless $('#request_rdate').val() == ''
        superCell[1] =  $('#request_rdate').val()
    else
        requestDataFlag = true
        $('#request_rdate').css('color','red')
        $('#request_rdate').val('¿ NO DATA ?')
        
    unless $('#request_sent_by').val() == ''
        superCell[2] = $('#request_sent_by').val()
    else
        requestDataFlag = true
        $('#request_sent_by').css('color','red')
        $('#request_sent_by').val('¿ NO DATA ?')
        
    unless $('#request_oriented').val() == ''
        superCell[3] = $('#request_oriented').val()
    else
        requestDataFlag = true
        $('#request_oriented').css('color','red')
        $('#request_oriented').val('¿ NO DATA ?')
        
    unless $('#request_service').val() == ''
        superCell[4] = $('#request_service').val()
    else
        requestDataFlag = true
        $('#request_service').css('color','red')
        $('#request_service').val('¿ NO DATA ?')
        
    unless $('#request_qualification').val() == ''
        superCell[5] = $('#request_qualification').val()
    else
        requestDataFlag = true
        $('#request_qualification').css('color','red')
        $('#request_qualification').val('¿ NO DATA ?')
        
    alert 'Faltaron datos de llenar en Caso' if requestDataFlag
    #superCell[6] = $('#request_notes').val()
    
    