class GearsController < ApplicationController
  def index
    @phantomOServices = OtherService.where(living_place:nil)
    @phantomBenefits = Benefit.where(person_id:nil)
    @phantomOExpeditures = OtherExpediture.where(expediture_id=nil)
  end
end
