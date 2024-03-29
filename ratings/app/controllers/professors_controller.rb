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
    # create an empty Rating so we can allow the user to 
    # fill it in on the show view
    @rating = @professor.ratings.new
  end

  # GET /professors/new
  #a view to ask the user for the information on the professor
  def new
    @professor = Professor.new
    # if we created multiple new ratings, they would all 
    # show up in the new view
    # The new Rating is put into the Professor's array of Ratings
    # that we can access in the view using @professors.ratings
    @professor.ratings.new
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
      params.require(:professor).permit(:first, :last, :university, ratings_attributes: [:course, :comment, :rating])
    end
end
