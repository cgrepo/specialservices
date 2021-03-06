personID = null
responsableID = null
requester = []
responsable = []
relative = []
relativeData = []
picChange = null
$(document).on "turbolinks:load", ->
    fillR()
    if personID == null
        tabsEnabled(false)
    setup()
    $('#save-person').on 'click', ->
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
                fillRE()
                spinner('OFF')
                $('.badge').text('1')
                $('#edit-person').show()
                $('#person_picture').hide()
                uploadPicture()
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#edit-person').on 'click', ->
        personDataUX('enable')
        $('a#update-person').fadeToggle('slow')
        $('a#edit-person').fadeToggle('slow')
        $('#person_picture').show()
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
                    born_place:requester[13]
                    workplace:requester[14]
            success: (data) ->
                personDataUX('disable')
                #console.log personID
                spinner('OFF')
                unless $('h1').text() == 'Edicion Solicitante'
                    $('.badge').text('1')
                    $('a#edit-person').fadeToggle('slow')
                    $('a#update-person').fadeToggle('slow')
                    fillRE()
                uploadPicture() if picChange
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#save-responsable').on 'click', ->
        spinner('ON')
        responsableDataGet()
        if $('h1').text() == 'Agregar Persona'
            theURL = '/people/addResponsable'
        $.ajax
            type:'POST'
            url: theURL
            dataType:'json'
            data:
                responsable:responsable
                person:personID
            success: (data) ->
                responsableDataUX('disable')
                $('a#save-responsable').hide()
                $('a#edit-responsable').show()
                $.each data, (element, value) ->
                    responsableID = value
                #console.log 'person='+personID + 'responsable=' + responsableID
                spinner('OFF')
                $('.badge').text('2')
                fillREL()
            error: (data) ->
                alert data
                spinner('OFF')
    $('a#edit-responsable').on 'click', ->
        $('a#update-responsable').show()
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
                    name:responsable[0]
                    age:responsable[1]
                    gender:responsable[2]
                    civil_status:responsable[3]
                    salary:responsable[4]
                    address:responsable[5]
                    occupation:responsable[6]
                    workplace:responsable[7]
                    relationship:responsable[8]
            success: (data) ->
                responsableDataUX('disable')
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
                                    $('a#save_relatives').show()
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
    $('#save_relatives').on 'click', ->
        relative = []
        $('#relationshipTable tbody tr').each ->
            relativeData = []
            $(this).find('td').each ->
                relativeData.push($(this).text()) unless $(this).text() == ''
            relative.push(relativeData)
        # console.log 'relative--------->' + relative
        # console.log 'relative.length-->' + relative.length
        # console.log 'relative data' + relativeData
        spinner('ON')
        $.ajax
            type:'POST'
            url:'/people/addRelatives'
            dataType:'json'
            data:
                requester:personID
                responsable:responsableID
                relatives:relative
            success: (data) ->
                spinner('OFF')
                $('.badge').text('completado!')
                $('a#save_relatives').attr('disabled',true)
                $('a#addRelative').attr('disabled',true)
                #window.location.replace('/people/showrel?person='+personID+'&responsable='+responsableID+'&relatives='+data)
                window.location.replace('/people/'+personID)
            error: (data) ->
                alert data
                spinner('OFF')
    $('#person_picture').change ->
        prevPic this
        $('#img_prev').show()
        picChange = true
        # console.log picChange
        if picChange == true 
            $('#actual_picture').fadeToggle('slow') if $('h1').text() == 'Edicion Solicitante'
    
setup=->
    if $('h1').text() == 'Edicion Solicitante'
        $('#save-person').hide()
        $('#edit-person').hide()
        $('#update-person').show()
        $('#save-responsable').hide()
        $('#edit-responsable').hide()
        $('#img_prev').hide()
        tabsEnabled(true)
        personID = $('input#person_id').val()
        responsableID = $('input#responsable_id').val()
        $('.nav li#relative').addClass('disabled')
        $('.nav li#relative').find('a').removeAttr("data-toggle")
        $('.nav li#relative').hide()
        # console.log 'update'
    else
        $('#save_relatives').hide()
        $('#relativeSubmit').hide() if $('h1').text() == 'Agregar Persona'
        $('#edit-person').hide()
        $('#edit-responsable').hide()
        $('#update-person').hide()
        $('#update-responsable').hide()
        $('#addRelative').show()
        $('#img_prev').hide()
        $('#actual_picture').hide()
        # console.log 'insert'
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
    requester.push($('#person_born_place').val())
    requester.push($('#person_workplace').val())
    #console.log requester
uploadPicture=->
    formData = new FormData
    $input = $('#person_picture')
    formData.append 'person[picture]', $input[0].files[0]
    formData.append 'person[id]',personID
    $.ajax
        url: '/people/addPicture'
        type: 'POST'
        data: formData
        dataType: 'JSON'
        processData: false
        contentType: false
        cache: false
        success: (data) ->
            # console.log data
            picChange = false
checkRows=->
    rows = $('#relationshipTable tbody').children('tr').length
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
        $('#person_born_place').attr('disabled',true)
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
        $('#person_born_place').attr('disabled',false)
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
prevPic = (input) ->
  if input.files and input.files[0]
    reader = new FileReader
    reader.onload = (e) ->
      $('#img_prev').attr 'src', e.target.result
    reader.readAsDataURL input.files[0]

