# This controller does not have a show function
# since tags are shown by image, it does not make sense to
# show a single tag

class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]

  # GET /images/:image_id/tags
  def index
    # index is now all the tags for a single image (not all the tags)
    # the URL will contain the id of the current image (:image_id)
    # use the :image_id parameter to find all the tags
    @image = Image.find params[:image_id]
    # the has_many function called in app/models/image.rb created the 
    # function "tags" which will return an array of all the tags 
    # with the image foreign key matching @image
    @tags = @image.tags
  end

  # GET images/:image_id/tags/new
  # Create a new tag in the context of a Image object
  # that way the tags's foreign key (:image_id) will be
  # initialized correctly.
  def new
    # since our the tag new path contains the image's id
    # we can use params[:image_id] to get that id
    @image = Image.find params[:image_id]

    # This is similar to Tag.new, BUT it creates the new tag
    # in the context of a Image object and sets the foreign key
    @tag = @image.tags.new
  end

  # GET /tags/1/edit
  def edit
    # edit routes are not nested (we already know our image's foreign_key)
  end

  # POST images:/:image_id/tags
  # we need the image's key in the URL to make sure that someone 
  # isn't trying to hack the id of the new tag's image
  # rails ensures that the URL has not be tampered with
  def create
    @image = Image.find params[:image_id]
    @tag = @image.tags.new(tag_params)

    if @tag.save
      redirect_to image_tags_url(@image) , notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tags/1
  # updates don't have to be nested because the image foreign key is already set
  # and cannot be changed by edit (note that image_id is not permitted in tag_params())
  def update
    if @tag.update(tag_params)
      redirect_to image_tags_url(@tag.image), notice: 'Tag was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    redirect_to image_url(@tag.image) , notice: 'Tag was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:str)
    end
end
