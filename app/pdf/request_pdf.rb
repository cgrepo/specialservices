require 'active_support'

class RequestPdf < Prawn::Document
    def initialize(request)
        super()
        @request = request
        printpage1
        printpage2
    end
    
    private
        def printpage1()
		#------------------------------
		    Prawn::Font::AFM.hide_m17n_warning = true
			imgdif = "#{Rails.root.to_s}/app/assets/images/diflog.jpg"
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
    	    printLines_Page1
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
            table( data,header:true, :position=> :center,:cell_style=>{size:7, :padding=>[64,0,0,90]}) do
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
        
        def printLines_Page1
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
        
        def filledRectangles(x,y)
                fill_color 'cfd0cb'
        		stroke_color '9f9a9a'
                fill {rectangle [x,y], 15,15}
        end
        
        def print_livingConditions
            case @request.person.LivingPlace.kind
                when "PROPIA"
                    filledRectangles(112,515)
                when "RENTADA"
                    filledRectangles(112,500) 
                when "PRESTADA"
                    filledRectangles(112,485) 
                when "OTROS"
                    filledRectangles(112,470) 
            end
            case @request.person.LivingPlace.wall_material
                when "BLOCK"
                    filledRectangles(235,515)
                when "LADRILLO"
                    filledRectangles(235,500)
                when "CARTON"
                    filledRectangles(235,485)
                when "MADERA"
                    filledRectangles(235,470)
                when "OTROS"
                    filledRectangles(235,555)
            end
            case @request.person.LivingPlace.roof_material
                when "CONCRETO"
                    filledRectangles(365,515)
                when "CARTON"
                    filledRectangles(365,500) 
                when "PALMA"
                    filledRectangles(365,485) 
                when "OTROS"
                    filledRectangles(365,470) 
            end
            case @request.person.LivingPlace.floor_material
                when "MOSAICO"
                    filledRectangles(510,515)
                when "CEMENTO"
                    filledRectangles(510,500) 
                when "TIERRA"
                    filledRectangles(510,485) 
                when "OTROS"
                    filledRectangles(510,470) 
            end
            
            case @request.person.LivingPlace.ligth_service
                when "ELECTRICO"
                    filledRectangles(150,388)
                when "LAMPARA DE PETROLEO"
                    filledRectangles(150,373) 
                when "VELA"
                    filledRectangles(150,358) 
                when "OTROS"
                    filledRectangles(150,343) 
            end
            
            case @request.person.LivingPlace.water_service
                when "INTERDOMICILIARIA"
                    filledRectangles(315,388)
                when "PILA"
                    filledRectangles(315,373) 
                when "POZO"
                    filledRectangles(315,358) 
                when "OTROS"
                    filledRectangles(315,343) 
            end
            case @request.person.transportation
                when "PRIVADO"
                    filledRectangles(480,388)
                when "PUBLICO/TAXI"
                    filledRectangles(480,373) 
                when "PUBLICO/CAMION"
                    filledRectangles(480,358) 
                when "OTROS"
                    filledRectangles(480,343) 
            end
        end
        
        def printLines_Page2
		    stroke do
                self.line_width = 0.5
                horizontal_line 100,285, at:702
                horizontal_line 430,530, at:702
                horizontal_line 74,285, at:687
                horizontal_line 338,530, at:687
                horizontal_line 83,285, at:672
                horizontal_line 347,530, at:672
                horizontal_line 70,285, at:657
                horizontal_line 370,530, at:657
                horizontal_line 43,285, at:642
                horizontal_line 330,530, at:642
                horizontal_line 70,285, at:627
                horizontal_line 340,530, at:627
                horizontal_line 67,285, at:612
                horizontal_line 43,285, at:597
                horizontal_line 220,380, at:572
                #---------------------FILLED HEADERS------------------------------------------------------------------------------------------------------------------------
                
                fill_color 'cfd0cb'
    		    stroke_color '9f9a9a'
                
                rounded_rectangle [17,565],530,20,8 # condiciones de la vivienda
                rounded_rectangle [17,540],530,20,8 # habitacion paredes techo ....
                rounded_rectangle [17,420],530,20,8 # alumbrado servicio de agua ...
                
                fill_and_stroke
                
                formatted_text_box [ { :text => "CONDICIONES DE LA VIVIENDA: ", size:10, style:[:bold], color:'000000'} ], at:[200,558], width:180, height:20
                formatted_text_box [ { :text => "HABITACION", size:10, style:[:bold], color:'000000'} ], at:[50,534], width:80, height:20
                formatted_text_box [ { :text => "PAREDES", size:10, style:[:bold], color:'000000'} ], at:[187,534], width:80, height:20
                formatted_text_box [ { :text => "TECHO", size:10, style:[:bold], color:'000000'} ], at:[325,534], width:80, height:20
                formatted_text_box [ { :text => "PISO ", size:10, style:[:bold], color:'000000'} ], at:[475,534], width:80, height:20
                formatted_text_box [ { :text => "ALUMBRADO", size:10, style:[:bold], color:'000000'} ], at:[70,410], width:80, height:20
                formatted_text_box [ { :text => "SERVICIO DE AGUA", size:10, style:[:bold], color:'000000'} ], at:[240,410], width:100, height:20
                formatted_text_box [ { :text => "TRANSPORTE", size:10, style:[:bold], color:'000000'} ], at:[435,410], width:80, height:20
                #----------------------------------------------------------------------------------------------------------------------------------------------------------
                rounded_rectangle [17,520],530,90,8 # contenido
                vertical_line 540,430, at:145
                
                rectangle [112,515],15,60 # para habitacion
                horizontal_line 112,127, at:500
                horizontal_line 112,127, at:485
                horizontal_line 112,127, at:470
                
                vertical_line 540,430, at:270
                rectangle [235,515],15,75 # para paredes
                horizontal_line 235,250, at:500
                horizontal_line 235,250, at:485
                horizontal_line 235,250, at:470
                horizontal_line 235,250, at:455
                
                vertical_line 540,430, at:420
                rectangle [365,515],15,60 # para techo
                horizontal_line 365,380, at:500
                horizontal_line 365,380, at:485
                horizontal_line 365,380, at:470
                
                rectangle [510,515],15,60 # piso
                horizontal_line 510,525, at:500
                horizontal_line 510,525, at:485
                horizontal_line 510,525, at:470
                
                rounded_rectangle [17,400],530,90,8 # contenido
                vertical_line 420,310, at:199
                vertical_line 420,310, at:381
                
                rectangle [150,388],15,60 # alumbrado
                horizontal_line 150,165, at:373
                horizontal_line 150,165, at:358
                horizontal_line 150,165, at:343
                
                rectangle [315,388],15,60 # agua
                horizontal_line 315,330, at:373
                horizontal_line 315,330, at:358
                horizontal_line 315,330, at:343
                
                rectangle [480,388],15,60 # transporte
                horizontal_line 480,495, at:373
                horizontal_line 480,495, at:358
                horizontal_line 480,495, at:343
                
                horizontal_line 100,545, at:273
                horizontal_line 17,545, at:253
                horizontal_line 17,545, at:233
                horizontal_line 17,545, at:213
                horizontal_line 17,545, at:193
                horizontal_line 17,545, at:173
                horizontal_line 17,545, at:153
                horizontal_line 17,545, at:133
                horizontal_line 17,545, at:113
                horizontal_line 17,545, at:93
                horizontal_line 17,545, at:73
                
                horizontal_line 17,209, at:33
                horizontal_line 350,545, at:33
            end
            
            print_livingConditions
        end
        
        def printpage2
            start_new_page
            stroke_axis
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "Egresos Mensuales: ", size:9, style:[:bold], color:'000000'} ], at:[17,710], width:120, height:30
                formatted_text_box [ { :text => "Alimentacion: ", size:9, style:[:bold], color:'000000'} ], at:[17,695], width:120, height:30
                formatted_text_box [ { :text => "Renta de Casa: ", size:9, style:[:bold], color:'000000'} ], at:[17,680], width:120, height:30
                formatted_text_box [ { :text => "Electricidad: ", size:9, style:[:bold], color:'000000'} ], at:[17,665], width:120, height:30
                formatted_text_box [ { :text => "Agua: ", size:9, style:[:bold], color:'000000'} ], at:[17,650], width:120, height:30
                formatted_text_box [ { :text => "Combustible: ", size:9, style:[:bold], color:'000000'} ], at:[17,635], width:120, height:30
                formatted_text_box [ { :text => "Educacion: ", size:9, style:[:bold], color:'000000'} ], at:[17,620], width:120, height:30
                formatted_text_box [ { :text => "Otros: ", size:9, style:[:bold], color:'000000'} ], at:[17,605], width:120, height:30
                formatted_text_box [ { :text => "PRESTACIONES SOCIALES: ", size:9, style:[:bold], color:'000000'} ], at:[310,710], width:150, height:30
                formatted_text_box [ { :text => "IMSS: ", size:9, style:[:bold], color:'000000'} ], at:[310,695], width:120, height:30
                formatted_text_box [ { :text => "ISSSTE: ", size:9, style:[:bold], color:'000000'} ], at:[310,680], width:120, height:30
                formatted_text_box [ { :text => "PARTICULAR: ", size:9, style:[:bold], color:'000000'} ], at:[310,665], width:120, height:30
                formatted_text_box [ { :text => "DIF: ", size:9, style:[:bold], color:'000000'} ], at:[310,650], width:120, height:30
                formatted_text_box [ { :text => "OTRO: ", size:9, style:[:bold], color:'000000'} ], at:[310,635], width:120, height:30
                formatted_text_box [ { :text => "TOTAL: ", size:10, style:[:bold], color:'000000'} ], at:[180,580], width:120, height:30
                
                
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "PROPIA ", size:9, style:[:bold], color:'000000'} ], at:[40,510], width:80, height:20
                formatted_text_box [ { :text => "RENTADA ", size:9, style:[:bold], color:'000000'} ], at:[40,495], width:80, height:20
                formatted_text_box [ { :text => "PRESTADA ", size:9, style:[:bold], color:'000000'} ], at:[40,480], width:80, height:20
                formatted_text_box [ { :text => "OTROS ", size:9, style:[:bold], color:'000000'} ], at:[40,465], width:80, height:20
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "BLOCK ", size:9, style:[:bold], color:'000000'} ], at:[170,510], width:80, height:20
                formatted_text_box [ { :text => "LADRILLO ", size:9, style:[:bold], color:'000000'} ], at:[170,495], width:80, height:20
                formatted_text_box [ { :text => "CARTON ", size:9, style:[:bold], color:'000000'} ], at:[170,480], width:80, height:20
                formatted_text_box [ { :text => "MADERA ", size:9, style:[:bold], color:'000000'} ], at:[170,465], width:80, height:20
                formatted_text_box [ { :text => "OTROS ", size:9, style:[:bold], color:'000000'} ], at:[170,450], width:80, height:20
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "CONCRETO ", size:9, style:[:bold], color:'000000'} ], at:[300,510], width:80, height:20
                formatted_text_box [ { :text => "CARTON ", size:9, style:[:bold], color:'000000'} ], at:[300,495], width:80, height:20
                formatted_text_box [ { :text => "PALMA ", size:9, style:[:bold], color:'000000'} ], at:[300, 480], width:80, height:20
                formatted_text_box [ { :text => "OTROS ", size:9, style:[:bold], color:'000000'} ], at:[300,465], width:80, height:20
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "MOSAICO ", size:9, style:[:bold], color:'000000'} ], at:[450,510], width:80, height:20
                formatted_text_box [ { :text => "CEMENTO ", size:9, style:[:bold], color:'000000'} ], at:[450,495], width:80, height:20
                formatted_text_box [ { :text => "TIERRA ", size:9, style:[:bold], color:'000000'} ], at:[450, 480], width:80, height:20
                formatted_text_box [ { :text => "OTROS ", size:9, style:[:bold], color:'000000'} ], at:[450, 465], width:80, height:20
            #----------------------------------------------------------------------------------------------------------------------------------------------
                
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "ELECTRICO ", size:9, style:[:bold], color:'000000'} ], at:[87,385], width:80, height:20
                formatted_text_box [ { :text => "LAMPARA DE PETROLEO ", size:9, style:[:bold], color:'000000'} ], at:[30,370], width:140, height:20
                formatted_text_box [ { :text => "VELA ", size:9, style:[:bold], color:'000000'} ], at:[115, 355], width:400, height:20
                formatted_text_box [ { :text => "OTROS ", size:9, style:[:bold], color:'000000'} ], at:[107,340], width:400, height:20
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "INTERDOMICILIARIA ", size:9, style:[:bold], color:'000000'} ], at:[215,385], width:100, height:20
                formatted_text_box [ { :text => "PILA ", size:9, style:[:bold], color:'000000'} ], at:[285,370], width:80, height:20
                formatted_text_box [ { :text => "POZO ", size:9, style:[:bold], color:'000000'} ], at:[280, 355], width:80, height:20
                formatted_text_box [ { :text => "OTROS ", size:9, style:[:bold], color:'000000'} ], at:[275,340], width:80, height:20
            #----------------------------------------------------------------------------------------------------------------------------------------------
                formatted_text_box [ { :text => "PROPIO ", size:9, style:[:bold], color:'000000'} ], at:[435,385], width:80, height:20
                formatted_text_box [ { :text => "TAXI ", size:9, style:[:bold], color:'000000'} ], at:[450,370], width:80, height:20
                formatted_text_box [ { :text => "CAMION ", size:9, style:[:bold], color:'000000'} ], at:[435, 355], width:80, height:20
                formatted_text_box [ { :text => "OTROS ", size:9, style:[:bold], color:'000000'} ], at:[440,340], width:80, height:20
            
            formatted_text_box [ { :text => "OBSERVACIONES :", size:9, style:[:bold], color:'000000'} ], at:[17,280], width:90, height:10 
            
            print_notes
            doMaths
            formatted_text_box [ { :text => "FIRMA DEL BENEFICIARIO", size:9, style:[:bold], color:'000000'} ], at:[50,25], width:120, height:10
            formatted_text_box [ { :text => "FIRMA DEL TRABAJADOR SOCIAL", size:9, style:[:bold], color:'000000'} ], at:[380,25], width:150, height:10
            printLines_Page2
        end
        
        def print_notes
            #75 bytes
            first_line=@request.notes.slice!(0,75)
            formatted_text_box [ { :text => first_line, size:9, style:[:bold], color:'000000'} ], at:[110,280], width:430, height:10 
            #92 bytes
            row = 260
            @request.notes.scan(/.{92}/).each do |chunck|
              formatted_text_box [ { :text => chunck, size:9, style:[:bold], color:'000000'} ], at:[17,row], width:530, height:10 
              row = row - 20
            end
        end
        
        def doMaths
            fe  = @request.person.Expediture.first.fuel
            ed  = @request.person.Expediture.first.education
            f = @request.person.Expediture.first.feeding
            r = @request.person.Expediture.first.rent
            e  = @request.person.Expediture.first.electricity
            w = @request.person.Expediture.first.water
            oes = OtherExpediture.where(Expediture:Expediture.find_by(person:@request.person))
            @total_other_expeditures = 0
            oes.each { |oe| @total_other_expeditures = @total_other_expeditures + oe.amount}
            total_expeditures = fe+ed+f+r+e+w+@total_other_expeditures
            
            benefits = Benefit.where :person => @request.person
            @total_other_benefits = 0
            benefits.each do |benefit|
                
                case benefit.name
                    when 'IMSS'
                        @ims = benefit.amount
                    when 'ISSSTE'
                        @iste = benefit.amount
                    when 'PARTICULAR'
                        @pri = benefit.amount
                    when 'DIF'
                        @dif = benefit.amount
                    else
                        @total_other_benefits = @total_other_benefits + benefit.amount
                end
            end
            
            @ims = 0.0 unless @ims
            @iste = 0.0 unless @iste
            @pri = 0.0 unless @pri
            @dif = 0.0 unless @dif
            
            total_benefits = @ims + @iste + @pri + @dif + @total_other_benefits
            
            total = total_benefits + total_expeditures
            
            formatted_text_box [ { :text => "$#{total.to_s}", size:9, style:[:bold], color:'000000'} ], at:[250,580], width:80, height:10
            formatted_text_box [ { :text => "$#{total_benefits.to_s}", size:9, style:[:bold], color:'000000'} ], at:[450,709], width:80, height:10
            formatted_text_box [ { :text => "$#{@ims.to_s}", size:9, style:[:bold], color:'000000'} ], at:[450,694], width:80, height:10
            formatted_text_box [ { :text => "$#{@iste.to_s}", size:9, style:[:bold], color:'000000'} ], at:[450,679], width:80, height:10
            formatted_text_box [ { :text => "$#{@pri.to_s}", size:9, style:[:bold], color:'000000'} ], at:[450,664], width:80, height:10
            formatted_text_box [ { :text => "$#{@dif.to_s}", size:9, style:[:bold], color:'000000'} ], at:[450,649], width:80, height:10
            formatted_text_box [ { :text => "$#{@total_other_benefits.to_s}", size:9, style:[:bold], color:'000000'} ], at:[450,634], width:80, height:10
            
            formatted_text_box [ { :text => "$#{total_expeditures.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,709], width:80, height:10
            formatted_text_box [ { :text => "$#{f.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,694], width:80, height:10
            formatted_text_box [ { :text => "$#{r.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,679], width:80, height:10
            formatted_text_box [ { :text => "$#{e.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,664], width:80, height:10
            formatted_text_box [ { :text => "$#{w.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,649], width:80, height:10
            formatted_text_box [ { :text => "$#{fe.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,634], width:80, height:10
            formatted_text_box [ { :text => "$#{ed.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,619], width:80, height:10
            formatted_text_box [ { :text => "$#{@total_other_expeditures.to_s}", size:9, style:[:bold], color:'000000'} ], at:[120,604], width:80, height:10
        end
        
end
