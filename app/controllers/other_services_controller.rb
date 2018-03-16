class OtherServicesController < ApplicationController
  before_action :set_other_service, only: [:show, :update, :destroy]
  
  # def index
  #   @other_services = OtherService.all
  # end

  # def show
  # end

  # # def udpate
  # #   byebug
  # #   respond_to do |format|
  # #     if @otherService.update(other_service_params)
  # #       @otherServices = OtherService.where(living_place_id:@other_service.living_place_id)
  # #       format.js 
  # #     else
  # #       #format.js { render :edit }
  # #     end
  # #   end
  # # end
  
  def create
    @otherService = OtherService.new(other_service_params)
    respond_to do |format|
      if @otherService.save
        format.js 
      else
        format.js   { render :createFail }
        format.json { render json: @benefit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @otherService.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
    def set_other_service
      @otherService = OtherService.find(params[:id])
    end

    def other_service_params
      params.require(:other_service).permit(:name)
    end
end
