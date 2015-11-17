# This controller does not have a show function
# since image_users are shown by image, it does not make sense to
# show a single image_user

class ImageUsersController < ApplicationController
  before_action :set_image_user, only: [:destroy]

  # GET images/:image_id/image_users/new
  # Create a new image_user in the context of a Image object
  # that way the image_users's foreign key (:image_id) will be
  # initialized correctly.
  def new
    @image = Image.find params[:image_id]
    @image_user = @image.image_users.new
  end


  # POST images:/:image_id/image_users
  # we need the image's key in the URL to make sure that someone 
  # isn't trying to hack the id of the new image_user's image
  # rails ensures that the URL has not be tampered with
  def create
    @image = Image.find params[:image_id]
    @image_user = @image.image_users.new(image_user_params)

    if @image_user.save
      redirect_to image_url(@image) , notice: 'Permission was successfully created.'
    else
      render :new
    end
  end

  # DELETE /image_users/1
  def destroy
    @image_user.destroy
    redirect_to image_url(@image_user.image) , notice: 'Permission was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_image_user
      @image_user = ImageUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, 
    # only allow the white list through.
    def image_user_params
      params.require(:image_user).permit(:image_id, :user_id)
    end
end
