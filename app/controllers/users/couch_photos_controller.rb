class Users::CouchPhotosController < ApplicationController
  def new
    @photo = CouchPhoto.new
  end

  def create
    @photo = CouchPhoto.new(photo_params)
    if @photo.save!
      redirect_to user_couch_path(current_user, @photo)
    end
  end

  def show
  end

  private

  def photo_params
    params.require(:couch_photo).permit(:title, :caption, :image)
  end
end
