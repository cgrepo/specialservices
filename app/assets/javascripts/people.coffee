$(document).on "turbolinks:load", ->
    #$('div#relatives').addClass("disabledbutton")
    #$('div#responsables').addClass("disabledbutton")
    $('a#save_relatives').attr('disabled',true)
    $('a#btn-save-person').on 'click', ->
    $('a#addRelative').on 'click', ->
        name = $('#relative_name').val()
        age = $('#relative_age').val()
        gender = $('#relative_gender').val()
        civil = $('#relative_civil_status').val()
        salary = $('#relative_salary').val()
        occupation = $('#relative_occupation').val()
        scolar = $('#relative_scolarship').val()
        relationship = $('#relative_relationship').val()
        if name == ''
            alert 'debe proporcionar un nombre'
        else 
            if age == ''
                alert 'debe proporcionar la edad'
            else 
                if gender == ''
                    alert 'debe proporcionar el sexo'
                else 
                    if civil == ''
                        alert 'debe proporcionar el estado civil'
                    else 
                        if relationship == ''
                            alert 'debe proporcionar el parentesco'
                        else
                            $('#relationshipTable tbody').append('<tr><td>'+
                            name+'</td> <td>'+relationship+'</td> <td>'+age+'</td> <td>'+gender+'</td> <td>'+
                            scolar+'</td><td>'+civil+'</td> <td>'+occupation+
                            '</td><td><a class="btn btn-sm btn-default edrelative"><span class="glyphicon glyphicon-pencil"></span></a>'+
                            '</td><td><a class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-trash delrelative"></span></a></td></tr>' )
                            $('#relative_name').val('')
                            $('#relative_age').val('')
                            $('#relative_gender').val('')
                            $('#relative_civil_status').val('')
                            $('#relative_salary').val('')
                            $('#relative_occupation').val('')
                            $('#relative_scolarship').val('')
                            $('#relative_relationship').val('')
                            $('a#save_relatives').attr('disabled',false)
                            $('.edrelative').on 'click', ->
                                alert 'feho'
                            $('.delrelative').on 'dblclick', ->
                                alert 'feho'
#$row = $(this).closest('tr')
#alert $row.text()