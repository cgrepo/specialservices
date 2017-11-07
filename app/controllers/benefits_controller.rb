class BenefitsController < ApplicationController
  before_action :set_benefit, only: [:show, :update, :destroy]
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

  # PATCH/PUT /other_expeditures/1
  # PATCH/PUT /other_expeditures/1.json
  def update
    respond_to do |format|
      if @other_expediture.update(other_expediture_params)
        format.html { redirect_to @other_expediture, notice: 'Other expediture was successfully updated.' }
        format.json { render :show, status: :ok, location: @other_expediture }
      else
        format.html { render :edit }
        format.json { render json: @other_expediture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /other_expeditures/1
  # DELETE /other_expeditures/1.json
  def destroy
    @other_expediture.destroy
    respond_to do |format|
      format.html { redirect_to other_expeditures_url, notice: 'Other expediture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benefit
      @other_expediture = OtherExpediture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benefit_params
      params.require(:benefit).permit(:name)
    end
end
