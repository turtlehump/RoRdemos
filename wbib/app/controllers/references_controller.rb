# This controller does not have a show function
# since references are shown by topic, it does not make sense to
# show a single reference

class ReferencesController < ApplicationController
  before_action :set_reference, only: [:edit, :update, :destroy]

  # GET topics/:topic_id/references/new
  # Create a new reference in the context of a Topic object
  # that way the Reference's foreign key (topic_id) will be
  # initialized correctly.
  def new
    # since our the reference new path contains the topic's id
    # we can use params[:topic_id] to get that id
    @topic = Topic.find params[:topic_id]

    # This is similar to Reference.new, BUT it creates the new reference
    # in the context of a Topic object and sets the foreign key
    @reference = @topic.references.new
  end

  # GET /references/1/edit
  def edit
    # edit routes are not nested (we already know our topic's foreign_key)
  end

  # POST topics:/:topic_id/references
  # we need the topic's key in the URL to make sure that someone 
  # isn't trying to hack the id of the new reference's topic
  # rails ensures that the URL has not be tampered with
  def create
    @topic = Topic.find params[:topic_id]
    @reference = @topic.references.new(reference_params)

    if @reference.save
      redirect_to topic_url(@topic) , notice: 'Reference was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /references/1
  # updates don't have to be nested because the topic foreign key is already set
  # and cannot be changed by edit (note that topic_id is not permitted in reference_params())
  def update
    if @reference.update(reference_params)
      redirect_to topic_url(@reference.topic), notice: 'Reference was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /references/1
  def destroy
    @reference.destroy
    redirect_to topic_url(@reference.topic) , notice: 'Reference was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = Reference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_params
      params.require(:reference).permit(:URL)
    end
end
