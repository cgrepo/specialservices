class ExpedituresController < ApplicationController
  before_action :set_expediture, only: [:update]
  def update
    respond_to do |format|
      if @expediture.update(expediture_params)
        format.js
      else
        format.js {render :updateFail}
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expediture
      @expediture = Expediture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expediture_params
      params.require(:expediture).permit(:feeding, :rent, :electricity, :water, :fuel, :education)
    end
end
