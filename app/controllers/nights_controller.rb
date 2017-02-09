class NightsController < ApplicationController

  def new
    @night = Night.new
  end

  def create
    night = Night.new(night_params)
    if night.save
      flash[:success] = "Made night(s) available!"
      redirect_to couch_path(couch)
    else
      flash[:alert] = night.error.full_messages
      redirect_to new_night_path
    end
  end

  private

    def night_params
      params.permit("First Night", "Last Night")
    end
end
