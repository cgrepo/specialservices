require 'active_support'

class RequestPdf < Prawn::Document
    def initialize(request)
        super()
        formatted_text_box [
    	    { :text => request.id, size:13, style:[:bold], font:"Verdana", 
    	      color:'000000'}, 
    	], at:[120,710], width:320, height:200
    end
end
