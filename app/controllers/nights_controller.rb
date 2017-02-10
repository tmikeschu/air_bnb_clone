class NightsController < ApplicationController

  def new
    @night = Night.new
  end

  def create
    # night = Night.new(night_params
    couch = Couch.find(params[:couch_id])
    ActiveRecord::Base.transaction do
    night_params.each do |night|
      couch.nights.create!(date: night)
    end
  end
    byebug
    if Night.last
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
      x = params["First Night"].split("/").join(" ")
      y = params["Last Night"].split("/").join(" ")
      first_date = Date.strptime(x, '%m %d %Y')
      last_date = Date.strptime(y, '%m %d %Y')
      (first_date..last_date).to_a
    end
end
