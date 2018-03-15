class LivingPlacesController < ApplicationController
  before_action :set_livingPlace, only: [:update]
  def update
    respond_to do |format|
      if @livingPlace.update(livingPlace_params)
        format.js
      else
        format.js {render :updateFail}
      end
    end
  end
  private
    def set_livingPlace
      @livingPlace = LivingPlace.find(params[:id])
    end

    def livingPlace_params
      params.require(:living_place).permit(
        :kind, :wall_material, :roof_material, :water, :floor_material, :number_of_rooms,
        :has_beedroom, :has_kitchen, :has_dinningroom, :has_bathroom, :notes)
    end
end
