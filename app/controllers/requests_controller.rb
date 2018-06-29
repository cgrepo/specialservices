class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :showPDF]

  def index
    @requests = Request.all
  end

  def show
    @expediture = Expediture.find_by(person:@request.person)
    @person = @request.person
    @otherExpeditures = OtherExpediture.where(Expediture:@expediture)
    @benefits = Benefit.where(person:@request.person)
    @living = LivingPlace.find_by(person:@request.person)
    @otherservices = OtherService.where(living_place:@living)
  end

  def new
    @request = Request.new
    @expediture = Expediture.new
    @livingPlace = LivingPlace.new
  end
  
  def edit
    @person = Person.find(@request.person)
    @expediture = Expediture.find_by(person_id:@person)
    # check how more expeditures are
      @otherExpeditures = OtherExpediture.where(Expediture:@expediture)
    # check how more benefits are
      @benefits = Benefit.where(person:@request.person)
    # check how many other services
      @living = LivingPlace.find_by(person_id:@person)
      @otherServices = OtherService.where(living_place:@living)
  end

  def create
    respond_to do |format|
      @request = fillRequest(Request.new)
      if @request.save
        @expediture = fillExpeditures(Expediture.new)
        #check if has more expeditures
        if @expediture.save
          fillOtherExpediture(@expediture)
          fillBenefits()
        else
          #error saving request
        end
        #check if has benefits
        @livingPlace = fillLivigPlace(LivingPlace.new,@person)
        if @livingPlace.save
          fillOtherService(@livingPlace)
        else
          #error savign living place
        end
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
      else
        #error saving request
      end
    end
    #@request = 
    #appRdata(@request)
    
    # @request = Request.new(request_params)
    # 
    #   if @request.save
    #     format.html { redirect_to @request, notice: 'Request was successfully created.' }
    #     format.json { render :show, status: :created, location: @request }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @request.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # Mine-----------------------
    def showmodal
      respond_to do |format|
        case params[:key]
          when 'expediture'
            @otherExpediture = OtherExpediture.new
            format.html {render :partial => 'modal4expediture'}
          when 'person'
            # Dont add person search and select the person Daa!
            @persons = Person.where('name LIKE ?','%'+params[:val]+'%')
            format.html {render :partial => 'modalPSearch'}
          when 'service' #vivienda servicios
            @other_service = OtherService.new
            format.html {render :partial => 'modal4service'}
          when 'benefit' #gastos prestacin nueva
            @benefit = Benefit.new
            format.html {render :partial => 'modal4benefit'}
          when 'kind'
            format.html {render :partial => 'modal4otherKind'}
          when 'wall'
            format.html {render :partial => 'modal4wall'}
          when 'roof'
            format.html {render :partial => 'modal4roof'}
          when 'floor'
            format.html {render :partial => 'modal4floor'}
        end
      end
    end
    def showPDF
      respond_to do |format|
        format.pdf do
          
          #pdf = Prawn::Document.new
          pdf = RequestPdf.new(@request)
          send_data pdf.render, 
            filename: "reques#{@request.id}.pdf",
            type: 'application/pdf',
            disposition: 'inline'
        end
      end
    end
    
    def edOExpediture
      @otherExpediture = OtherExpediture.find(params[:id])
      respond_to do |format|
        format.js
      end
    end
    
    def edBenefit
      @benefit = Benefit.find(params[:id])
      respond_to do |format|
        format.js
      end
    end
    
    def edOService
      @otherService = OtherService.find(params[:id])
      respond_to do |format|
        format.js
      end
    end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:case, :rdate, :sent_by, :oriented, :service, :notes, :qualification, :person_id)
    end
    
    def fillRequest(request)
      request.case          = params[:rdata][0]
      request.rdate         = params[:rdata][1]
      request.sent_by       = params[:rdata][2]
      request.oriented      = params[:rdata][3]
      request.service       = params[:rdata][4]
      request.notes         = params[:rdata][5]
      request.qualification = params[:rdata][6]
      request.person_id     = params[:pid]
      return request
    end
    
    def fillExpeditures(expediture)
      expediture.feeding     = params[:edata][0]
      expediture.rent        = params[:edata][1]
      expediture.electricity = params[:edata][2]
      expediture.water       = params[:edata][3]
      expediture.fuel        = params[:edata][4]
      expediture.education   = params[:edata][5]
      expediture.person_id   = params[:pid]
      return expediture
    end
    
    def fillOtherExpediture(expediture)
      unless params[:oedata][0] == 'false'
        params[:oedata].each do |oe|
          otherExpediture = OtherExpediture.find(oe)
          otherExpediture.expediture_id = expediture.id
          # add code to rise error on not being able to update the info
          otherExpediture.save
        end
      end
    end
    
    def fillBenefits()
      unless params[:bdata][0] == 'false'
        params[:bdata].each do |b|
          benefit = Benefit.find(b)
          benefit.person_id = params[:pid]
          # add code to rise error on not being able to update the info
          benefit.save
        end
      end
    end
    
    def fillOtherService(livingPlace)
      unless params[:osdata][0] == 'false'
        params[:osdata].each do |o|
          otherService = OtherService.find(o)
          otherService.living_place_id = livingPlace.id
          # add code to rise error on not being able to update the info
          otherService.save
        end
      end
    end
    
    def fillLivigPlace(livingPlace,person)
      livingPlace.kind            = params[:ldata][0]
      livingPlace.wall_material   = params[:ldata][1]
      livingPlace.roof_material   = params[:ldata][2]
      livingPlace.floor_material  = params[:ldata][3]
      livingPlace.number_of_rooms = params[:ldata][4]
      byebug
      livingPlace.water_service   = params[:ldata][5]
      livingPlace.notes           = params[:ldata][6]
      livingPlace.has_beedroom    = params[:rooms][:beedroom]
      livingPlace.has_kitchen     = params[:rooms][:kitchen]
      livingPlace.has_dinningroom = params[:rooms][:dinningroom]
      livingPlace.has_bathroom    = params[:rooms][:bathroom]
      livingPlace.Person_id       = params[:pid]
      return livingPlace
    end
end
