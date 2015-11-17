# This controller does not have an edit page.
# You cannot edit a image, only delete and upload a new one
class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]

  # GET /professors
  def index
    @imgs = Image.all
    iu = ImageUser.all
    if current_user
      @owned_imgs = @imgs.map {|image| image if image.user == current_user}.compact
      @private_imgs = iu.map {|image_user| image_user.image if image_user.user == current_user}.compact
      @imgs = @imgs - @owned_imgs
      @imgs = @imgs - @private_imgs
    end
    @public_imgs = @imgs.map {|image| image if !image.private}.compact
  end

  # GET /images/1
  def show
    @tag = @image.tags.new
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images
  def create
    @image = Image.new(image_params)

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
      params.require(:image).permit(:name, :filename, :private)
    end
end
