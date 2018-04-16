require 'active_support'

class RequestPdf < Prawn::Document
    def initialize(request)
        super()
        @request = request
        printpage1
        table_relationships
    end
    
    private
        def printpage1
            Prawn::Font::AFM.hide_m17n_warning = true
			imgdif = "#{Rails.root.to_s}/app/assets/images/diflog.jpg"
			image imgdif, at: [17,720], fit:[70,70]
			photo = "#{Rails.root.to_s}/public/#{@request.person.picture.to_s}"
			image photo, at: [17,667], fit:[80,80]
			stroke_axis
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
    	    { :text => "Fecha de nacimiento: #{@request.person.birth_date}",size:9, style:[:bold], color:'000000' },
            { :text => " #{@request.person.birth_date.day} de #{@request.person.birth_date.month} del #{@request.person.birth_date.year}", size:9, style:[:bold], color:'000000' }
    	    ], at:[320,560], width:280, height:30
    	    formatted_text_box [
    	    { :text => "Residencia actual: #{@request.person.current_residence}",size:9, style:[:bold], color:'000000' },
            { :text => "    Domicilio: #{@request.person.current_residence}", size:9, style:[:bold], color:'000000' }
    	    ], at:[17,540], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Preparacion Escolar: #{@request.person.scolarship}",size:9, style:[:bold], color:'000000' },
    	    ], at:[17,520], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Ocupacion: #{@request.person.occupation}",size:9, style:[:bold], color:'000000' },
    	    { :text => "    Salario mensual: #{@request.person.salary}",size:9, style:[:bold], color:'000000' }
    	    ], at:[17,500], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Lugar de trabajo: #{@request.person.workplace}",size:9, style:[:bold], color:'000000' },
    	    { :text => "    Fecha de ingreso: #{@request.person.admission_date}",size:9, style:[:bold], color:'000000' }
    	    ], at:[17,480], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Servicio solicitado: #{@request.service}",size:9, style:[:bold], color:'000000' },
    	    ], at:[17,460], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Preparacion Escolar: #{@request.person.responsable.name}",size:9, style:[:bold], color:'000000' },
    	    ], at:[17,440], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Parentesco: #{@request.person.responsable.relationship}",size:9, style:[:bold], color:'000000' },
    	    { :text => "    Edad: #{@request.person.responsable.age}",size:9, style:[:bold], color:'000000' },
    	    ], at:[17,420], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Sexo:   M(  )    F( )", size:9, style:[:bold], color:'000000'}, 
            { :text => "    Estado Civil:   Soltero(    )  Casado(  )   Union Libre(    )  Viudo(   )    Otro(  ) ", size:9, style:[:bold], color:'000000'}, 
    	    ], at:[17,400], width:480, height:30
    	    formatted_text_box [
    	    { :text => "Ocupacion:  #{@request.person.responsable.occupation}", size:9, style:[:bold], color:'000000'}, 
            { :text => "    Lugar de trabajo:   #{@request.person.responsable.occupation}", size:9, style:[:bold], color:'000000'},
            { :text => "    Salario mensual:    #{@request.person.responsable.salary}", size:9, style:[:bold], color:'000000'}, 
    	    ], at:[17,380], width:480, height:30
    	    formatted_text_box [
    	    { :text => "Domicilio:  #{@request.person.responsable.address}", size:9, style:[:bold], color:'000000'}, 
            { :text => "    Domicilio actual:   #{@request.person.responsable.address}", size:9, style:[:bold], color:'000000'}
    	    ], at:[17,360], width:480, height:30
        end
        
        def table_relationships
            formatted_text_box [
        	    { :text => "ESTRUCTURA FAMILIAR", size:12, style:[:bold], color:'000000'}, 
        	    ], at:[197,335], width:480, height:30
    	    
            move_down 390
            data = [['NOMBRE','PARENTESCO','EDAD','SEXO','ECOLARIDAD','ESTADO CIVIL','OCUPACION']]
            @request.person.relatives.each do |relative| 
                data += [[relative.name,relative.relationship,relative.age,relative.gender,relative.scolarship,relative.civil_status,relative.occupation]]
            end
            table( data,header:true, :position=> 17,:cell_style=>{size:7, :padding=>[64,0,0,90]}) do
                cells.padding = 12
                cells.borders = []
                row(0).borders = [:bottom]
                row(0).border_width = 3
                row(0).font_style = :bold
                #columns(0..1).borders = [:right]
                #cells.columns(1..-1).rows(1..-1)
            end
            stroke do
                rounded_rectangle [10,340], 540,330,10
            end
        end
end
