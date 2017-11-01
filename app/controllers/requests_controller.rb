class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
    @expediture = Expediture.new
    @livingPlace = LivingPlace.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
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

  # DELETE /requests/1
  # DELETE /requests/1.json
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
            @otherService = OtherService.new
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
          pdf = ServiceRequestPdf.new(@service_request)
          send_data pdf.render, 
            filename: "reques#{@person.id}.pdf",
            type: 'application/pdf',
            disposition: 'inline'
        end
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
end
