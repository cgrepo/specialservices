$(document).on "turbolinks:load", ->
    $('div#relatives').addClass("disabledbutton")
    $('div#responsables').addClass("disabledbutton")
    $('a#btn-save-person').on 'click', ->
#        alert 'clicket do save the person now move to responsable'
#        $('li#person').removeClass('active')
#        $('li#responsable').addClass('active')
#        $('div#responsables').removeClass("disabledbutton")
#        $('div#responsables').addClass("active in")
        