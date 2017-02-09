class CouchesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @couch = @user.couches.new
  end

  def create
    byebug
    couch = Couch.create(couch_params)
    redirect_to couch_path(couch)
  end

  def show
    @couch = current_user.couches.find(params[:couch_id])
  end

  private
    def couch_params
      params.require(:couch).permit(:name,
                                    :street_address,
                                    :city,
                                    :state,
                                    :zipcode)
    end
end