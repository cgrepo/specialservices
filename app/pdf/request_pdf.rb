require 'active_support'

class RequestPdf < Prawn::Document
    def initialize(request)
        super()
        @request = request
        printpage1
    end
    
    private
        def printpage1()
            
            Prawn::Font::AFM.hide_m17n_warning = true
			imgdif = "#{Rails.root.to_s}/app/assets/images/diflog.jpg"
		#------------------------------
			image imgdif, at: [17,720], fit:[120,120]
			photo = "#{Rails.root.to_s}/public/#{@request.person.picture.to_s}"
			image photo, at: [260,667], fit:[80,80]
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
    	       ], at:[345,667], width:200, height:30
    	    formatted_text_box [
                	    { :text => "Canalizado a:   #{@request.oriented}", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[345,647], width:200, height:30
    	    formatted_text_box [
                	    { :text => "Fecha:   #{@request.created_at}", size:9, style:[:bold], color:'000000'}, 
    	       ], at:[345,627], width:200, height:30
    	    #-----------------------------
    	    formatted_text_box [
            { :text => "Nombre del beneficiario:  #{@request.person.name}", size:9, style:[:bold], color:'000000'} 
    	    ], at:[17,600], width:200, height:30
    	    
    	    @request.person.gender == 'M' ? pgen = 'M ( X )    F (  ) ' : pgen = 'M (  )    F ( X ) '
    	    formatted_text_box [
            { :text => "Sexo: #{pgen}   ", size:9, style:[:bold], color:'000000'}, 
    	    ], at:[17,580], width:200, height:30
    	    
    	    case @request.person.civil_status
        	    when 'SOLTERO'
        	        cstat = 'Soltero ( X )          Casado (  )               Union Libre (  )            Viudo (  )                Otro (  )'
    	    end
    	    formatted_text_box [ { :text => "Estado Civil:   #{cstat}", size:9, style:[:bold], color:'000000'}, 
    	     ], at:[120,580], width:420, height:30
    	    formatted_text_box [
    	       { :text => "Lugar de nacimiento:    #{@request.person.born_place}", size:9, style:[:bold], color:'000000'}, 
    	    ], at:[17,560], width:200, height:30
    	    formatted_text_box [
    	    { :text => "Fecha de nacimiento: #{@request.person.birth_date}",size:9, style:[:bold], color:'000000' },
            { :text => " #{@request.person.birth_date.day} de #{@request.person.birth_date.month} del #{@request.person.birth_date.year}", size:9, style:[:bold], color:'000000' }
    	    ], at:[320,560], width:280, height:30
    	    
    	    @request.person.current_residence.length > 21 ? crsize = 7 : crsize = 9
    	    formatted_text_box [
    	    { :text => "Residencia actual: #{@request.person.current_residence}",size:crsize, style:[:bold], color:'000000' }
    	    ], at:[17,540], width:200, height:30
    	    
    	    formatted_text_box [
            { :text => "Domicilio: #{@request.person.current_residence}", size:9, style:[:bold], color:'000000' }
    	    ], at:[214,540], width:200, height:30
    	    formatted_text_box [
    	    { :text => "Preparacion Escolar: #{@request.person.scolarship}",size:9, style:[:bold], color:'000000' },
    	    ], at:[17,520], width:500, height:30
    	    
    	    formatted_text_box [
    	    { :text => "Ocupacion:    #{@request.person.occupation}",size:9, style:[:bold], color:'000000' }
    	    ], at:[17,500], width:300, height:30
    	    
    	    formatted_text_box [
    	    { :text => "Salario mensual $ #{@request.person.salary}",size:9, style:[:bold], color:'000000' }
    	    ], at:[317,500], width:200, height:30
    	    
    	    formatted_text_box [
    	    { :text => "Lugar de trabajo: #{@request.person.workplace}",size:9, style:[:bold], color:'000000' }
    	    ], at:[17,480], width:500, height:30
    	    
    	    formatted_text_box [
    	    { :text => "Fecha de ingreso: #{@request.person.admission_date}",size:9, style:[:bold], color:'000000' }
    	    ], at:[317,480], width:500, height:30
    	    
    	    formatted_text_box [
    	    { :text => "Servicio solicitado: #{@request.service}",size:9, style:[:bold], color:'000000' },
    	    ], at:[17,460], width:500, height:30
    	    formatted_text_box [
    	    { :text => "Preparacion Escolar: #{@request.person.responsable.name}",size:9, style:[:bold], color:'000000' },
    	    ], at:[17,440], width:500, height:30
    	    
    	    formatted_text_box [
    	    { :text => "Parentesco: #{@request.person.responsable.relationship}",size:9, style:[:bold], color:'000000' }
    	    ], at:[17,420], width:500, height:30
    	    
    	    formatted_text_box [
    	    { :text => "    Edad: #{@request.person.responsable.age}",size:9, style:[:bold], color:'000000' },
    	    ], at:[365,420], width:500, height:30
    	    
    	    @request.person.responsable.gender == 'M' ? rgen = 'M ( X )    F (  ) ' : rgen = 'M (  )    F ( X ) '
    	    formatted_text_box [
    	    { :text => "Sexo:   #{rgen}", size:9, style:[:bold], color:'000000'} 
    	    ], at:[17,400], width:480, height:30
    	    case @request.person.responsable.civil_status
        	    when 'SOLTERO'
        	        rcstat = 'Soltero ( X )          Casado (  )               Union Libre (  )            Viudo (  )                Otro (  )'
        	    when 'UNION LIBRE'
        	        rcstat = 'Soltero (  )          Casado (  )               Union Libre ( X )            Viudo (  )                Otro (  )'
    	    end
    	    formatted_text_box [
            { :text => "Estado Civil:   #{rcstat}", size:9, style:[:bold], color:'000000'}
    	    ], at:[120,400], width:480, height:30
    	    @request.person.responsable.occupation.length > 18  ? zixe = 7 : zixe = 9
    	    formatted_text_box [
    	    { :text => "Ocupacion:  #{@request.person.responsable.occupation}", size:zixe, style:[:bold], color:'000000'}
    	    ], at:[17,380], width:480, height:30
    	    
    	    @request.person.responsable.workplace.length > 38  ? zixe = 7 : zixe = 9
    	    formatted_text_box [
            { :text => "    Lugar de trabajo:   #{@request.person.responsable.workplace}", size:zixe, style:[:bold], color:'000000'}
    	    ], at:[170,380], width:480, height:30
    	    
    	    formatted_text_box [
            { :text => "    Salario mensual:    #{@request.person.responsable.salary}", size:9, style:[:bold], color:'000000'}, 
    	    ], at:[390,380], width:480, height:30
    	    
    	    formatted_text_box [
    	    { :text => "Domicilio:  #{@request.person.responsable.address}", size:9, style:[:bold], color:'000000'}
    	    ], at:[17,360], width:480, height:30
    	    formatted_text_box [
            { :text => "    Residencia actual:   #{@request.person.responsable.address}", size:9, style:[:bold], color:'000000'}
    	    ], at:[317,360], width:480, height:30
    	    
    	    table_relationships
    	    printLines
        end
        
        def table_relationships
            formatted_text_box [
        	    { :text => "ESTRUCTURA FAMILIAR", size:12, style:[:bold], color:'000000'}, 
        	    ], at:[197,335], width:480, height:30
    	    
            move_down 400
            data = [['NOMBRE','PARENTESCO','EDAD','SEXO','ECOLARIDAD','ESTADO CIVIL','OCUPACION']]
            # rowcount = 1
            @request.person.relatives.each do |relative| 
                data += [[relative.name,relative.relationship,relative.age,relative.gender,relative.scolarship,relative.civil_status,relative.occupation]]
                # rowcount+=1
            end
            table( data,header:true, :position=> 17,:cell_style=>{size:7, :padding=>[64,0,0,90]}) do
                cells.padding = 12
                #cells.borders = [:left, :right]
                cells.borders = []
                row(0).borders = [:bottom,:top]
                row(0).border_width = 0.5
                row(0).font_style = :bold
                row(0).background_color = 'f0f0f0'
                # byebug
                # (1..rowcount).each do |idx|
                #     if idx.odd?
                #         row(idx).background_color = '707070'
                #     else
                #         row(idx).background_color = '707570'
                #     end
                # end
                #rows(1..-1).columns(0).background_color = '737373'
                #rowcount.odd? ? rows(1..-1).columns(0).background_color = '737373' : rows(1..-1).columns(0).background_color = '730003'
                # byebug
                # rows(1..-1).each_with_index do |row,index|
                #     index.odd? ? row(index).columns(2..4).background_color = '737373' : row(index).columns(2..4).background_color = '737373'
                # end
            end
        end
        
        def printLines
            stroke do
                self.line_width = 0.5
                horizontal_line 382,530, at:659 #no exp
                horizontal_line 403,530, at:639 #canalizado
                horizontal_line 375,530, at:619 #fecha
                
                horizontal_line 115,530, at:592 # NOMBRE
                
                horizontal_line 110,318, at:553
                horizontal_line 408,530, at:553
                
                horizontal_line 93,210, at:532
                horizontal_line 255,530, at:532 # Domicilio
                
                horizontal_line 103,530, at:512 # universidad
                
                horizontal_line 63,310, at:493 # ocupacion
                horizontal_line 390,530, at:493 # salario mensual
                
                horizontal_line 78,310, at:472 # lugar trabajo
                horizontal_line 390,530, at:472 # fecha ingreso
                
                horizontal_line 94,530, at:452 # servicio
                
                horizontal_line 103,530, at:433 # preparacion escolar
                
                horizontal_line 65,360, at:412 # parentesco 
                horizontal_line 390,530, at:412 # edad
                
                horizontal_line 63,168, at:372 # parentesco 
                horizontal_line 240,389, at:372 # edad
                horizontal_line 460,530, at:372 # parentesco 
                
                horizontal_line 60,315, at:352 # edad
                horizontal_line 395,530, at:352 # edad
                
                rounded_rectangle [5,340],530,330,4
            end
            
        end
end
