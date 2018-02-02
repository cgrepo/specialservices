class RelativesController < ApplicationController
  before_action :set_person, only: [ :update, :destroy, :edit]
  def index
  end

  def update
  end
  
  def new
    @relative = Relative.new
  end
  
  def create
    @person = Person.find_by :id => params[:idPerson]
    
    byebug
  end

  def destroy
    @relative.destroy
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
    def relative_params
      params.require(:relative).permit(:name, :age, :gender, :civil_status, :salary,:occupation, :scolarship, :relationship, :person_id)
    end
    # def responsable_params
    #   params.require(:responsable).permit(:name, :age, :gender, :civil_status, :salary, :address, :occupation, :workplace, :relationship)
    # end
end
