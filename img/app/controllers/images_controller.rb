# This controller does not have an edit page.
# You cannot edit a image, only delete and upload a new one
class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]

  # GET /professors
  def index
    @imgs = Image.all.shuffle
    iu = ImageUser.all
    if current_user
      @owned_imgs = @imgs.map {|image| image if image.user == current_user}.compact.shuffle
      @private_imgs = iu.map {|image_user| image_user.image if image_user.user == current_user}.compact.shuffle
      @imgs = @imgs - @owned_imgs
      @imgs = @imgs - @private_imgs
    end
    @public_imgs = @imgs.map {|image| image if !image.private}.compact.shuffle
  end

  # GET /images/1
  def show
    @tag = @image.tags.new
    @inside_users = @image.image_users.map { |iu| iu.user }.compact
    @users = User.all
    cur_user = [current_user]           #hacky
    @possible_users = @users - cur_user #hacky
    @outsider_users = @possible_users - @inside_users
    @outsider_users.delete_if {|usr| usr.admin}
    @image_user = @image.image_users.new
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images
  def create
    @image = Image.new(image_params)
    @image.generate_filename
    @image.user = current_user
    @uploaded_io = params[:image][:uploaded_file]

    File.open(Rails.root.join('public', 'images', @image.filename), 'wb') do |file|
        file.write(@uploaded_io.read)
    end

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
      redirect_to @image, notice: 'Image was not updated.'
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
