personID = null
requ = []
expe = []
oexp = []
bene = []
vita = []
serv = []
has = {bedroom:false,kitchen:false,dinningroom:false,bathroom:false}
$(document).on 'turbolinks:load', ->
    setup()
    $('#seachPpl').on 'click', ->
        unless $('input#name').val() == ''
            spinner('ON',$('#spinnerContainer4case'))
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
                        spinner('OFF',$('#spinnerContainer4case'))
                        fillCase()
                        fillExp()
                        tabsEnabled(true)
                        caseUIEnabled(true)
                error: (response) ->
                    spinner('OFF',$('#spinnerContainer4case'))
                    alert response
        else
            alert 'proporcionar el nombre a buscar'
    $('#editPpl').on 'click', ->
        $('input#name').val('')
        $('input#name').attr('disabled',false)
        $('#editPpl').fadeToggle('slow')
        $('#seachPpl').fadeToggle('slow')
    $('#addExpediture').on 'click', ->
        spinner('ON',$('#spinnerContainer4exp'))
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
        spinner('ON',$('#spinnerContainer4exp'))
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
        spinner('ON',$('#spinnerContainer4liv'))
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
        if validCaseData()
            if validExpensivesData()
                if validLivingData()
                    console.log 'request data ' + requ
                    console.log 'expedit data ' + expe
                    console.log 'oexpedi data ' + oexp
                    console.log 'benefit data ' + bene
                    console.log 'living  data ' + vita
                    console.log 'oservic data ' + serv
                    spinner('ON',$('#spinnerContainer4liv'))
                    $.ajax
                        type:'POST'
                        url:'/requests'
                        data:
                            rdata:requ,
                            edata:expe,
                            oedata:oexp,
                            bdata:bene,
                            osdata:serv,
                            ldata:vita
                            rooms:has
                            
                        success: (response) ->
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
        spinner('OFF',$('#spinnerContainer4case'))
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
    $('#modal-window2').on 'hidden.bs.modal', ->
        spinner('OFF',$('#spinnerContainer4exp'))
    $('#modal-window3').on 'hidden.bs.modal', ->
        spinner('OFF',$('#spinnerContainer4liv'))
        if $('h4').attr('id') == 'newKind'
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
spinner=(opt,container) ->
    if opt == 'ON'
        container.spin
            lines: 12
            length: 7
            width: 8
            radius: 6
            color: 'blue'
            # speed: 1
            trail: 60
            shadow: false
    if opt == 'OFF'
        container.spin false
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
validCaseData=->
    requestDataFlag = false
    unless $('#request_case').val() == ''
        requ[0] =  $('#request_case').val()
    else
        requestDataFlag = true
        $('#request_case').css('color','red')
        $('#request_case').val('¿ NO DATA ?') 
    
    unless $('#request_rdate').val() == ''
        requ[1] =  $('#request_rdate').val()
    else
        requestDataFlag = true
        $('#request_rdate').css('color','red')
        $('#request_rdate').val('¿ NO DATA ?')
        
    unless $('#request_sent_by').val() == ''
        requ[2] = $('#request_sent_by').val()
    else
        requestDataFlag = true
        $('#request_sent_by').css('color','red')
        $('#request_sent_by').val('¿ NO DATA ?')
        
    unless $('#request_oriented').val() == ''
        requ[3] = $('#request_oriented').val()
    else
        requestDataFlag = true
        $('#request_oriented').css('color','red')
        $('#request_oriented').val('¿ NO DATA ?')
        
    unless $('#request_service').val() == ''
        requ[4] = $('#request_service').val()
    else
        requestDataFlag = true
        $('#request_service').css('color','red')
        $('#request_service').val('¿ NO DATA ?')
        
    unless $('#request_qualification').val() == ''
        requ[5] = $('#request_qualification').val()
    else
        requestDataFlag = true
        $('#request_qualification').css('color','red')
        $('#request_qualification').val('¿ NO DATA ?')
    
    requ[6] = $('#request_notes').val()
    alert 'Faltaron datos de llenar en Caso' if requestDataFlag
    return true unless requestDataFlag
validExpensivesData=->
    requestExpensivesDataFlag = false
    unless $('#expediture_feeding').val() == ''
        expe[0] = $('#expediture_feeding').val()
    else
        requestExpensivesDataFlag = true
        $('#expediture_feeding').css('color','red')
        $('#expediture_feeding').val(0)
    
    unless $('#expediture_rent').val() == ''
        expe[1] = $('#expediture_rent').val()
    else
        requestExpensivesDataFlag = true
        $('#expediture_rent').css('color','red')
        $('#expediture_rent').val(0)
    
    unless $('#expediture_electricity').val() == ''
        expe[2] = $('#expediture_electricity').val()
    else
        requestExpensivesDataFlag = true
        $('#expediture_electricity').css('color','red')
        $('#expediture_electricity').val(0)
    
    unless $('#expediture_water').val() == ''
        expe[3] = $('#expediture_water').val()
    else
        requestExpensivesDataFlag = true
        $('#expediture_water').css('color','red')
        $('#expediture_water').val(0)
    
    unless $('#expediture_fuel').val() == ''
        expe[4] = $('#expediture_fuel').val()
    else
        requestExpensivesDataFlag = true
        $('#expediture_fuel').css('color','red')
        $('#expediture_fuel').val(0)
        
    unless $('#expediture_education').val() == ''
        expe[5] = $('#expediture_education').val()
    else
        requestExpensivesDataFlag = true
        $('#expediture_education').css('color','red')
        $('#expediture_education').val(0)
    alert 'faltan datos de capturar en Gastos' if requestExpensivesDataFlag
    getExpeditureIDs() if $('#otherExpedituresTable tbody').children('tr').length > 0
    getBenefitsIDs() if $('#benefitsTable tbody').children('tr').length > 0
    return true unless requestExpensivesDataFlag
validLivingData=->
    requestLivigDataFlag = false
    vita[0] =$('#living_place_kind').val()
    vita[1] =$('#living_place_wall_material').val()
    vita[2] =$('#living_place_roof_material').val()
    vita[3] =$('#living_place_floor_material').val()
    unless $('#living_place_number_of_rooms').val() == ''
        vita[4] =$('#living_place_number_of_rooms').val()
    else
        requestLivigDataFlag = true
        $('#living_place_number_of_rooms').css('color','red')
        $('#living_place_number_of_rooms').val(0)
    has.bedroom = true if $('#living_place_has_beedroom').is(':checked')
    has.kitchen = true if $('#living_place_has_kitchen').is(':checked')
    has.dinningroom = true if $('#living_place_has_dinningroom').is(':checked')
    has.bathroom = true if $('#living_place_has_bathroom').is(':checked')
    alert 'datos faltantes de capturar en Vivienda' if requestLivigDataFlag
    getServicesIDs() if $('#servicesTable tbody').children('tr').length > 0
    return true unless requestLivigDataFlag
        
getExpeditureIDs=->
    $('#otherExpedituresTable tbody tr').each ->
        console.log 'getting other expeditures ' + $(this).find('td').eq(3).text()
        oexp.push($(this).find('td').eq(3).text())
getBenefitsIDs=->
    $('#benefitsTable tbody tr').each ->
        console.log 'getting other benetits ' + $(this).find('td').eq(3).text()
        bene.push($(this).find('td').eq(3).text())
getServicesIDs=->
    $('#servicesTable tbody tr').each ->
        console.log 'getting other services ' + $(this).find('td').eq(2).text()
        serv.push($(this).find('td').eq(2).text())
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         