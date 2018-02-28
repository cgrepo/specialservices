class GearsController < ApplicationController
  def index
    @phantomOServices = OtherService.where(living_place:nil)
    @phantomBenefits = Benefit.where(person_id:nil)
    @phantomOExpeditures = OtherExpediture.where(expediture_id:nil)
  end
  
  def nuke
    OtherService.where(living_place:nil).destroy_all
    Benefit.where(person_id:nil).destroy_all
    OtherExpediture.where(expediture_id:nil).destroy_all
    respond_to do |format|
      format.html {render :index, notice: 'unlinked data successfully finished.'}
    end
  end
end
