class ProfessorsController < ApplicationController
  before_action :set_professor, only: [:show, :edit, :update, :destroy]

  # GET /professors
  #all professors
  def index
    @professors = Professor.all
  end

  # GET /professors/1
  #only one professor
  def show
  end

  # GET /professors/new
  #a view to ask the user for the information on the professor
  def new
    @professor = Professor.new
  end

  # GET /professors/1/edit
  #edit only one professor
  def edit
  end

  # POST /professors
  #making the actual professor object and puting it in the DB
  def create
    @professor = Professor.new(professor_params)

    if @professor.save
      redirect_to @professor, notice: 'Professor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /professors/1
  def update
    if @professor.update(professor_params)
      redirect_to @professor, notice: 'Professor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /professors/1
  def destroy
    @professor.destroy
    redirect_to professors_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professor
      @professor = Professor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def professor_params
      params.require(:professor).permit(:first, :last, :university)
    end
end
