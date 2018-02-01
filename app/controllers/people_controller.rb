class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :updatePerson, :showPDF]

  def index
    @people = Person.all
  end

  def show
    @relatives = @person.relatives
  end

  def new
    @person = Person.new
    @responsable = Responsable.new
    @relative = Relative.new
  end

  def edit
    @responsable = Responsable.find_by(person_id:@person.id)
    @relative = Relative.new
  end

  def create
    @person = Person.new
    setPersonVal
    respond_to do |format|
      if @person.save
        format.json { render json: @person.as_json(only: [:id] ) }
      else
       format.html { render :new }
       format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def addPicture
    @person = Person.find_by(id:params[:person][:id])
    @person.picture = params[:person][:picture]
    respond_to do |format|
      if @person.save
        format.json { render json: @person.as_json(only: [:id] ) }
      else
       #format.html { render :new }
       format.json { render json: 'PICTURE UPLOAD FAIL', status: :unprocessable_entity }
      end
    end
  end
  
  def addResponsable
    @responsable = Responsable.new
    @responsable.Person_id = params[:person]
    @responsable.name = params[:responsable][0]
    @responsable.age= params[:responsable][1]
    @responsable.gender= params[:responsable][2]
    @responsable.civil_status= params[:responsable][3]
    @responsable.salary= params[:responsable][4]
    @responsable.address= params[:responsable][5]
    @responsable.occupation= params[:responsable][6]
    @responsable.workplace= params[:responsable][7]
    @responsable.relationship= params[:responsable][8]
    respond_to do |format|
      if @responsable.save
        format.json { render json: @responsable.as_json(only: [:id] ) }
      else
       format.html { render :new }
       format.json { render json: @responsable.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def updatePerson
    respond_to do |format|
      if @person.update(person_params)
        format.json { render json: @person.as_json(only: [:id] ), status: :ok }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def updateResponsable
    @responsable  = Responsable.find(params[:id])
    respond_to do |format|
      if @responsable.update(responsable_params)
        format.json { render json: @responsable.as_json(only: [:id] ), status: :ok }
      else
        format.json { render json: @responsable.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def addRelatives
    @relations = []
    problems = false
    respond_to do |format|
      params[:relatives].each do |r|
        @relative = Relative.new
        @relative.Person_id = params[:requester]
        @relative.name = r[1][0]
        @relative.relationship = r[1][1]
        @relative.age  = r[1][2]
        @relative.gender = r[1][3]
        @relative.scolarship = r[1][4]
        @relative.civil_status = r[1][5]
        @relative.occupation = r[1][6]
        @relative.salary = r[1][7]
        
        if @relative.save
          @relations << @relative.id
        else
          problems = true
        end
      end
      if problems
        format.json { render json: @relative.errors, status: :unprocessable_entity }
      else
        format.json { render json: @relations.as_json(only: [:id] ) }
      end
    end
  end


  
  # def getRelatives
  #   @relatives = Relative.where :Person_id => params[:id]
  #   byebug
  #   respond_to do |format|
  #     format.js {render :partial => 'getRelatives'}
  #   end
  # end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :age, :gender, :civil_status, :occupation, :salary, :scolarship, :address, :workplace, :current_residence, :phone, :admission_date, :birth_date, :transportation)
    end
    def responsable_params
      params.require(:responsable).permit(:name, :age, :gender, :civil_status, :salary, :address, :occupation, :workplace, :relationship)
    end
    def setPersonVal
      @person.name = params[:person][0]
      @person.age= params[:person][1]
      @person.gender= params[:person][2]
      @person.civil_status= params[:person][3]
      @person.salary= params[:person][4]
      @person.scolarship= params[:person][5]
      @person.phone= params[:person][6]
      @person.admission_date= params[:person][7]
      @person.birth_date= params[:person][8]
      @person.transportation= params[:person][9]
      @person.address= params[:person][10]
      @person.current_residence= params[:person][11]
      @person.occupation= params[:person][12]
      @person.workplace= params[:person][13]
      @person.picture= params[:person][14]
    end
end
