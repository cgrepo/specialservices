class BenefitsController < ApplicationController
  before_action :set_benefit, only: [:show, :update, :destroy]
   # GET /benefits
  # GET /benefits.json
  def index
    @benefits = Benefit.all
  end

  # GET /benefits/1
  # GET /benefits/1.json
  def show
  end

  # POST /benefits
  # POST /benefits.json
  def create
    @benefit = Benefit.new(benefit_params)
    respond_to do |format|
      if @benefit.save
        format.js 
      else
        format.js { render :fail }
        format.json { render json: @benefit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /benefits/1
  # PATCH/PUT /benefits/1.json
  def update
    respond_to do |format|
      if @benefit.update(benefit_params)
        @benefits = Benefit.where(person:@benefit.person)
        format.js
      else
        format.html {render :edit }
      end
    end
  end

  def destroy
    @benefit.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benefit
      @benefit = Benefit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benefit_params
      params.require(:benefit).permit(:name, :amount)
    end
end
