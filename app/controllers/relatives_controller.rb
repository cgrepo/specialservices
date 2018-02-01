class RelativesController < ApplicationController
  before_action :set_person, only: [ :update, :destroy, :edit]
  def index
  end

  def update
  end

  def destroy
    #@relative.destroy
    #byebug
    respond_to do |format|
      format.js
    end
  end
  
  def edit
  end
  
  private
    def set_person
      @relative = Relative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def relative_params
    #   params.require(:person).permit(:name, :age, :gender, :civil_status, :occupation, :salary, :scolarship, :address, :workplace, :current_residence, :phone, :admission_date, :birth_date, :transportation)
    # end
    # def responsable_params
    #   params.require(:responsable).permit(:name, :age, :gender, :civil_status, :salary, :address, :occupation, :workplace, :relationship)
    # end
end
