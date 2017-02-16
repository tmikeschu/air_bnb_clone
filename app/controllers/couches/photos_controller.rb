class Couches::PhotosController < ApplicationController
  def new
    @photo = CouchPhoto.new
    @couch = Couch.find(params["couch_id"])
  end

  def create
    couch = Couch.find(params["couch_id"])
    @photo = couch.photos.new(photo_params)
    if @photo.save!
      redirect_to user_couch_path(current_user, couch)
    else
      flash[:danger] = @photo.errors.full_messages.join(", ")
      redirect_to new_couch_photo_path
    end
  end

  private

  def photo_params
    params.require(:couch_photo).permit(:title, :caption, :image)
  end
end
