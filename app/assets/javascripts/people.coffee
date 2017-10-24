personID = null
responsableID = null
$(document).on "turbolinks:load", ->
    fillR()
    if personID == null
        tabsEnabled(false)
    $('a#save_relatives').attr('disabled',true)
    $('#barprog').hide()
    $('a#save-person').on 'click', ->
        spinner('ON')
        requester = []
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
        $.ajax
            type:'POST'
            url:'/people'
            dataType:'json'
            data:
                person:requester
            success: (data) ->
                #block edition
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
                $('a#save-person').fadeToggle()
                $.each data, (element, value) ->
                    personID = value
                tabsEnabled(true)
                console.log personID
                fillRE()
                spinner('OFF')
                $('.badge').text('1')
                $('#barprog').fadeToggle(3000)
                $('#bar').attr('width','33.33%')
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#save-responsable').on 'click', ->
        spinner('ON')
        responsable = []
        responsable.push($('#responsable_name').val())
        responsable.push($('#responsable_age').val())
        responsable.push($('#responsable_gender').val())
        responsable.push($('#responsable_civil_status').val())
        responsable.push($('#responsable_salary').val())
        responsable.push($('#responsable_address').val())
        responsable.push($('#responsable_occupation').val())
        responsable.push($('#responsable_workplace').val())
        responsable.push($('#responsable_relationship').val())
        $.ajax
            type:'POST'
            url:'/people/addResponsable'
            dataType:'json'
            data:
                responsable:responsable
                person:personID
            success: (data) ->
                #block edition
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
                $.each data, (element, value) ->
                    responsableID = value
                console.log 'person='+personID + 'responsable=' + responsableID
                spinner('OFF')
                $('.badge').text('2')
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
        alert 'dudes will be saves without person will put you back to fill this data :)'
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