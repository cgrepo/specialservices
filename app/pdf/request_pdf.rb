require 'active_support'

class RequestPdf < Prawn::Document
    def initialize(request)
        super()
        @request = request
        printHeaders()
    end
    
    private
        def printHeaders
            Prawn::Font::AFM.hide_m17n_warning = true
			imgdif = "#{Rails.root.to_s}/app/assets/images/diflog.jpg"
			image imgdif, at: [17,720], fit:[70,70]
			photo = "#{Rails.root.to_s}/public/#{@request.person.picture.to_s}"
			image photo, at: [17,667], fit:[80,80]
			
            formatted_text_box [
                	    { :text => "DESARROLLO INTEGRAL DE LA FAMILIA", size:16, style:[:bold], color:'000000'}, 
    	       ], at:[145,710], width:400, height:200
    	    formatted_text_box [
                	    { :text => "ESTUDIOS SOCIOECONOMICOS", size:12, style:[:bold], color:'000000'}, 
    	       ], at:[190,690], width:400, height:200
            #----------------------------
    	    formatted_text_box [
                	    { :text => "No. Exp.   #{@request.id}", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[345,660], width:200, height:30
    	    formatted_text_box [
                	    { :text => "Canalizado a:   #{@request.oriented}", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[345,648], width:200, height:30
    	    formatted_text_box [
                	    { :text => "Fecha:   #{@request.created_at}", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[345,636], width:200, height:30
    	   #-----------------------------
    	   formatted_text_box [
                	    { :text => "Nombre del beneficiario:   #{@request.person.name}", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[17,600], width:200, height:30
    	   formatted_text_box [
                	    { :text => "Sexo:   M( )    F( ) ", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[17,580], width:200, height:30
    	   formatted_text_box [
                	    { :text => "Estado Civil:   Soltero( )  Casado( )   Union Libre( )  Viudo( )    Otro( ) ", 
                	    size:9, style:[:bold], color:'000000'}, 
    	       ], at:[120,580], width:280, height:30
    	   formatted_text_box [
                	    { :text => "Lugar de nacimiento:    #{@request.person.born_place}", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[17,560], width:200, height:30
    	   formatted_text_box [
                	    { :text => "Estado Civil:   Soltero( )  Casado( )   Union Libre( )  Viudo( )    Otro( ) ", 
                	    size:9, style:[:bold], color:'000000'}, 
    	       ], at:[120,540], width:280, height:30
    	   
        end
end
