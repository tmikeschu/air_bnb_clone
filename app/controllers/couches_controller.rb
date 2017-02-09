class CouchesController < ApplicationController

  def new
    @couch = current_user.couches.new
  end

  def create
    couch = current_user.couches.new(couch_params)
    if couch.save
      flash[:success] = "Couch Created!"
      redirect_to user_couch_path(current_user, couch)
    else
      flash[:alert] = couch.error_messages.full
      redirect_to new_user_couch_path(current_user, couch)
    end
  end

  def show
    @couch = current_user.couches.find(params[:id])
  end

  private
    def couch_params
      params.require(:couch).permit(:name,
                                    :description,
                                    :street_address,
                                    :city,
                                    :state,
                                    :zipcode,
                                    :host)
    end
end
