class OtherExpedituresController < ApplicationController
  before_action :set_other_expediture, only: [:show, :update, :destroy]

  # GET /other_expeditures
  # GET /other_expeditures.json
  def index
    @other_expeditures = OtherExpediture.all
  end

  # GET /other_expeditures/1
  # GET /other_expeditures/1.json
  def show
  end

  # POST /other_expeditures
  # POST /other_expeditures.json
  def create
    @other_expediture = OtherExpediture.new(other_expediture_params)
    respond_to do |format|
      if @other_expediture.save
        #format.html
        format.js 
      else
        format.js { render :new }
        format.json { render json: @other_expediture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /other_expeditures/1
  # DELETE /other_expeditures/1.json
  def destroy
    @other_expediture.destroy
    respond_to do |format|
      format.js
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
