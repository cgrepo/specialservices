class OtherServicesController < ApplicationController
  before_action :set_other_service, only: [:show, :update, :destroy]
  
  def index
    @other_services = OtherService.all
  end

  def show
  end

  def create
    @other_service = OtherService.new(other_service_params)
    respond_to do |format|
      if @other_service.save
        format.js 
      else
        format.js { render :new }
        format.json { render json: @benefit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @other_service.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
    def set_other_service
      @other_service = OtherService.find(params[:id])
    end

    def other_service_params
      params.require(:other_service).permit(:name)
    end
end
