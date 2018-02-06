class RelativesController < ApplicationController
  before_action :set_relative, only: [ :update, :destroy, :edit]
  #before_action :set_person,   only: [ :new, :create]
  def index
  end

  def new
    @relative = Relative.new
    @person = Person.find_by(id:params[:Person_id])
  end
  
  def update
    @person = Person.find_by(id:@relative.Person_id)
    respond_to do |format|
      if @relative.update(relative_params)
        format.html { redirect_to @person, notice: 'Pariente actualizado.' }
        #format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        #format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    @relative = Relative.new(relative_params)
    @person = Person.find_by(id:params[:relative][:Person_id])
    respond_to do |format|
      if @relative.save
        format.html { redirect_to @person, notice: 'Pariente relacionado correctamente!' }
      else
        format.html { render :new }
      end
    end
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
    def set_relative
      @relative = Relative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relative_params
      params.require(:relative).permit(:name, :age, :gender, :civil_status, :salary,:occupation, :scolarship, :relationship, :Person_id)
    end
    # def responsable_params
    #   params.require(:responsable).permit(:name, :age, :gender, :civil_status, :salary, :address, :occupation, :workplace, :relationship)
    # end
end
