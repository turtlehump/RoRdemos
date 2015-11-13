class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /professors
  def index
    @images = Image.all
  end

  # GET /professors/1
  def show
  end

  # GET /professors/new
  def new
    @image = Image.new
  end

  # GET /professors/1/edit
  def edit
  end

  # POST /professors
  def create
    @image = Image.new(professor_params)

    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /professors/1
  def update
    if @image.update(image_params)
      redirect_to @image, notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /professors/1
  def destroy
    @image.destroy
    redirect_to images_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:filename, :private)
    end
end
