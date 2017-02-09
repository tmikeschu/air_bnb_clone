class CouchesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @couch = @user.couches.new
  end

  def create
    byebug
    user = User.find(params[:couch][:host].to_i)
    couch = Couch.create!(couch_params, host: user)
    redirect_to user_couch_path(couch)
  end

  def show
    @couch = current_user.couches.find(params[:couch_id])
  end

  private
    def couch_params
      params.require(:couch).permit(:name,
                                    :description,
                                    :street_address,
                                    :city,
                                    :state,
                                    :zipcode,
                                    :user_id,
                                    :host)
    end
end
