class Couches::PhotosController < ApplicationController
  def new
    @photo = CouchPhoto.new
  end

  def create

    couch = Couch.find(params["couch_id"])
    @photo = couch.photos.new(photo_params)
    if @photo.save!
      redirect_to user_couch_path(current_user, couch)
    end
  end

  private

  def photo_params
    params.require(:couch_photo).permit(:title, :caption, :image)
  end
end
