$(document).on "turbolinks:load", ->
    items = []
    $('a#save_relatives').attr('disabled',true)
    $('a#btn-save-person').on 'click', ->
    $('a#addRelative').on 'click', ->
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
                                checkRows()
                                $row = $(this).closest('tr')
                                $row.remove()
                                
checkRows=->
    rows = $('#relationshipTable tbody').children('tr').length
    if rows == 0
        $('#save_relatives').attr('disabled',true)