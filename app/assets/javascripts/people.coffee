personID = null
responsableID = null
requester = []
responsable = []
relative = []
relativeData = []
$(document).on "turbolinks:load", ->
    fillR()
    if personID == null
        tabsEnabled(false)
    setup()
    $('a#save-person').on 'click', ->
        spinner('ON')
        personDataGet()
        $.ajax
            type:'POST'
            url:'/people'
            dataType:'json'
            data:
                person:requester
            success: (data) ->
                personDataUX('disable')
                $('a#save-person').fadeToggle()
                $.each data, (element, value) ->
                    personID = value
                tabsEnabled(true)
                console.log personID
                fillRE()
                spinner('OFF')
                $('.badge').text('1')
                $('a#edit-person').attr('disabled',false)
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#edit-person').on 'click', ->
        personDataUX('enable')
        $('a#update-person').fadeToggle('slow')
        $('a#edit-person').fadeToggle('slow')
    $('a#update-person').on 'click', ->
        requester = []
        personDataGet()
        spinner('ON')
        $.ajax
            type:'PUT'
            url:'/people/updatePerson/'+personID
            data:
                person:
                    name:requester[0]
                    age:requester[1]
                    gender:requester[2]
                    civil_status:requester[3]
                    salary:requester[4]
                    scolarship:requester[5]
                    phone:requester[6]
                    admission_date:requester[7]
                    birth_date:requester[8]
                    transportation:requester[9]
                    address:requester[10]
                    current_residence:requester[11]
                    occupation:requester[12]
                    workplace:requester[13]
            success: (data) ->
                personDataUX('disable')
                tabsEnabled(true)
                console.log personID
                fillRE()
                spinner('OFF')
                $('.badge').text('1')
                $('a#edit-person').fadeToggle('slow')
                $('a#update-person').fadeToggle('slow')
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#save-responsable').on 'click', ->
        spinner('ON')
        responsableDataGet()
        $.ajax
            type:'POST'
            url:'/people/addResponsable'
            dataType:'json'
            data:
                responsable:responsable
                person:personID
            success: (data) ->
                responsableDataUX('disable')
                $('a#save-responsable').fadeToggle('slow')
                $.each data, (element, value) ->
                    responsableID = value
                console.log 'person='+personID + 'responsable=' + responsableID
                spinner('OFF')
                $('.badge').text('2')
                $('a#edit-responsable').attr('disabled',false)
                fillREL()
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#edit-responsable').on 'click', ->
        $('a#update-responsable').fadeToggle('slow')
        $('a#edit-responsable').fadeToggle('slow')
        responsableDataUX('enable')
    $('a#update-responsable').on 'click', ->
        responsable = []
        responsableDataGet()
        spinner('ON')
        $.ajax
            type:'PUT'
            url:'/people/updateResponsable/'+responsableID
            data:
                responsable:
                    name:requester[0]
                    age:requester[1]
                    gender:requester[2]
                    civil_status:responsable[3]
                    salary:responsable[4]
                    address:responsable[5]
                    occupation:responsable[6]
                    workplace:responsable[7]
                    relationship:responsable[8]
            success: (data) ->
                responsableDataUX('disable')
                tabsEnabled(true)
                spinner('OFF')
                $('a#edit-responsable').fadeToggle('slow')
                $('a#update-responsable').fadeToggle('slow')
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#addRelative').on 'click', ->
        items = []
        $name = $('#relative_name')
        $age = $('#relative_age')
        $gender = $('#relative_gender')
        $civil = $('#relative_civil_status')
        $salary = $('#relative_salary')
        $occupation = $('#relative_occupation')
        $scolar = $('#relative_scolarship')
        $relationship = $('#relative_relationship')
        if $name.val() == ''
            alert 'debe proporcionar un nombre'
        else 
            if $age.val() == '' || $age.val() == null
                alert 'debe proporcionar la edad'
            else 
                if $gender.val() == ''
                    alert 'debe proporcionar el sexo'
                else 
                    if $civil.val() == ''
                        alert 'debe proporcionar el estado civil'
                    else 
                        if $relationship.val() == ''
                            alert 'debe proporcionar el parentesco'
                        else
                            if $occupation.val() == ''
                                 alert 'debe proporcionar la ocupacion'
                            else
                                if $scolar.val() == ''
                                    alert 'debe proporcionar la escolaridad'
                                else
                                    $('#relationshipTable tbody').append('<tr><td>'+
                                    $name.val()+'</td> <td>'+$relationship.val()+'</td> <td>'+$age.val()+'</td> <td>'+
                                    $gender.val()+'</td> <td>'+$scolar.val()+'</td><td>'+$civil.val()+'</td> <td>'+$occupation.val()+
                                    '</td><td><a class="btn btn-sm btn-default edrelative"><span class="glyphicon glyphicon-pencil"></span></a>'+
                                    '</td><td><a class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-trash delrelative"></span></a></td></tr>' )
                                    $('#relative_name').val('')
                                    $('#relative_age').val('')
                                    $('#relative_gender').val('M')
                                    $('#relative_civil_status').val('CASADO')
                                    $('#relative_salary').val('')
                                    $('#relative_occupation').val('')
                                    $('#relative_scolarship').val('')
                                    $('#relative_relationship').val('')
                                    $('a#save_relatives').attr('disabled',false)
                                    $('.edrelative').on 'click', ->
                                        $row = $(this).closest('tr')
                                        $row.find('td').each ->
                                            items.push($(this).text())
                                        $name.val(items[0])
                                        $relationship.val(items[1])
                                        $age.val(items[2])
                                        $gender.val(items[3])
                                        $scolar.val(items[4])
                                        $civil.val(items[5])
                                        $occupation.val(items[6])
                                        $row.remove()
                                        checkRows()
                                    $('.delrelative').on 'click', ->
                                        $row = $(this).closest('tr')
                                        $row.remove()
                                        checkRows()
    $('a#save_relatives').on 'click', ->
        relative = []
        $('#relationshipTable tbody tr').each ->
            relativeData = []
            $(this).find('td').each ->
                relativeData.push($(this).text()) unless $(this).text() == ''
            #relative.push(['|'])
            relative.push([relativeData])
        console.log 'relative[0]------>' + relative[0]
        console.log 'relative[0][0]--->' + relative[0][0]
        console.log 'relative[0][1]--->' + relative[0][1]
        console.log 'relative[1][0]--->' + relative[1][0]
        console.log 'relative[1][1]--->' + relative[1][1]
        console.log 'relative--------->' + relative
        console.log 'relative.length-->' + relative.length
        $.ajax
            type:'POST'
            url:'/people/addRelatives'
            dataType:'json'
            data:
                relatives:relative
            success: (data) ->
                spinner('OFF')
                $('.badge').text('completado!')
                $('a#save_relatives').attr('disabled',true)
                $('a#addRelative').attr('disabled',true)
                fillREL()
            error: (data) ->
                alert data
                spinner('OFF')
setup=->
    $('a#save_relatives').attr('disabled',true)
    $('a#edit-person').attr('disabled',true)
    $('a#update-person').hide()
    $('a#edit-responsable').attr('disabled',true)
    $('a#update-responsable').hide()
checkRows=->
    rows = $('#relationshipTable tbody').children('tr').length
    alert rows
    if rows == 0
        $('#save_relatives').attr('disabled',true)
tabsEnabled=(opt) ->
    if opt
        $('.nav li#responsable').removeClass('disabled')
        $('.nav li#responsable').find('a').attr("data-toggle","tab")
        $('.nav li#relative').removeClass('disabled')
        $('.nav li#relative').find('a').attr("data-toggle","tab")
        $('.nav li#responsable').fadeToggle('slow')
        $('.nav li#relative').fadeToggle('slow')
    else
        $('.nav li#responsable').hide()
        $('.nav li#relative').hide()
        $('.nav li#responsable').addClass('disabled')
        $('.nav li#responsable').find('a').removeAttr("data-toggle")
        $('.nav li#relative').addClass('disabled')
        $('.nav li#relative').find('a').removeAttr("data-toggle")
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
personDataUX=(opt) ->
    if opt == 'disable'
        $('#person_name').attr('disabled',true)
        $('#person_age').attr('disabled',true)
        $('#person_gender').attr('disabled',true)
        $('#person_civil_status').attr('disabled',true)
        $('#person_salary').attr('disabled',true)
        $('#person_scolarship').attr('disabled',true)
        $('#person_phone').attr('disabled',true)
        $('#person_admission_date').attr('disabled',true)
        $('#person_birth_date').attr('disabled',true)
        $('#person_transportation').attr('disabled',true)
        $('#person_address').attr('disabled',true)
        $('#person_current_residence').attr('disabled',true)
        $('#person_occupation').attr('disabled',true)
        $('#person_workplace').attr('disabled',true)
    else
        $('#person_name').attr('disabled',false)
        $('#person_age').attr('disabled',false)
        $('#person_gender').attr('disabled',false)
        $('#person_civil_status').attr('disabled',false)
        $('#person_salary').attr('disabled',false)
        $('#person_scolarship').attr('disabled',false)
        $('#person_phone').attr('disabled',false)
        $('#person_admission_date').attr('disabled',false)
        $('#person_birth_date').attr('disabled',false)
        $('#person_transportation').attr('disabled',false)
        $('#person_address').attr('disabled',false)
        $('#person_current_residence').attr('disabled',false)
        $('#person_occupation').attr('disabled',false)
        $('#person_workplace').attr('disabled',false)
responsableDataUX=(opt) ->
    if opt == 'disable'
        $('#responsable_name').attr('disabled',true)
        $('#responsable_age').attr('disabled',true)
        $('#responsable_gender').attr('disabled',true)
        $('#responsable_civil_status').attr('disabled',true)
        $('#responsable_salary').attr('disabled',true)
        $('#responsable_address').attr('disabled',true)
        $('#responsable_occupation').attr('disabled',true)
        $('#responsable_workplace').attr('disabled',true)
        $('#responsable_relationship').attr('disabled',true)
    else
        $('#responsable_name').attr('disabled',false)
        $('#responsable_age').attr('disabled',false)
        $('#responsable_gender').attr('disabled',false)
        $('#responsable_civil_status').attr('disabled',false)
        $('#responsable_salary').attr('disabled',false)
        $('#responsable_address').attr('disabled',false)
        $('#responsable_occupation').attr('disabled',false)
        $('#responsable_workplace').attr('disabled',false)
        $('#responsable_relationship').attr('disabled',false)
personDataGet=->
    requester.push($('#person_name').val())
    requester.push($('#person_age').val())
    requester.push($('#person_gender').val())
    requester.push($('#person_civil_status').val())
    requester.push($('#person_salary').val())
    requester.push($('#person_scolarship').val())
    requester.push($('#person_phone').val())
    requester.push($('#person_admission_date').val())
    requester.push($('#person_birth_date').val())
    requester.push($('#person_transportation').val())
    requester.push($('#person_address').val())
    requester.push($('#person_current_residence').val())
    requester.push($('#person_occupation').val())
    requester.push($('#person_workplace').val())
responsableDataGet=->
    responsable.push($('#responsable_name').val())
    responsable.push($('#responsable_age').val())
    responsable.push($('#responsable_gender').val())
    responsable.push($('#responsable_civil_status').val())
    responsable.push($('#responsable_salary').val())
    responsable.push($('#responsable_address').val())
    responsable.push($('#responsable_occupation').val())
    responsable.push($('#responsable_workplace').val())
    responsable.push($('#responsable_relationship').val())
fillR=->
    $('#person_name').val('ScorpKing one')
    $('#person_age').val(100)
    $('#person_gender').val('M')
    $('#person_civil_status').val('SOLTERO')
    $('#person_salary').val('100290')
    $('#person_scolarship').val('UNIVERSIDAD')
    $('#person_phone').val('0009329')
    $('#person_admission_date').val('22/10/2017')
    $('#person_birth_date').val('01/12/1800')
    $('#person_transportation').val('PUBLICO')
    $('#person_address').val('UNKONW')
    $('#person_current_residence').val('INFERNALMALESTRROM')
    $('#person_occupation').val('HITTER')
    $('#person_workplace').val('UNDERGROUND')
fillRE=->
    $('#responsable_name').val('ARK NODE')
    $('#responsable_age').val('180')
    $('#responsable_gender').val('F')
    $('#responsable_civil_status').val('UNION LIBRE')
    $('#responsable_salary').val(696969)
    $('#responsable_address').val('UNKONW')
    $('#responsable_occupation').val('CELEBRATE')
    $('#responsable_workplace').val('UNDERGROUND')
    $('#responsable_relationship').val('UHMUCULO')
fillREL=->
    $('#relative_name').val('SABARON SUBARU SABAYON')
    $('#relative_age').val('123')
    $('#relative_gender').val('M')
    $('#relative_civil_status').val('SOLTERO')
    $('#relative_salary').val('2901')
    $('#relative_occupation').val('FUXLOK')
    $('#relative_scolarship').val('UNIVERSIDAD')
    $('#relative_relationship').val('PATHER')