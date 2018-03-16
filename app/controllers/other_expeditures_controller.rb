class OtherExpedituresController < ApplicationController
  before_action :set_other_expediture, only: [:show, :update, :destroy]
  def index
    @other_expeditures = OtherExpediture.all
  end
  
  def show
  end
  
  def create
    @other_expediture = OtherExpediture.new(other_expediture_params)
    respond_to do |format|
      if @other_expediture.save
        format.js 
      else
        format.js   { render :createFail }
        format.json { render json: @other_expediture.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @other_expediture.destroy
    respond_to do |format|
      format.js
    end
  end
  
  def update
    respond_to do |format|
      if @other_expediture.update(other_expediture_params)
        @otherExpeditures = OtherExpediture.where(expediture_id:@other_expediture.expediture_id)
        format.js 
      else
        format.html { render :edit }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_other_expediture
      @other_expediture = OtherExpediture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def other_expediture_params
      params.require(:other_expediture).permit(:name, :amount)
    end
end
