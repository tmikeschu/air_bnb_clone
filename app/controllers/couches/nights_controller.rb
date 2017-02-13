class Couches::NightsController < ApplicationController

  def new
    @night = Night.new
  end

  def create
    couch = current_user.couches.find(params[:couch_id])
    begin
      Night.transaction do
        night_params.each do |night|
          couch.nights.create!(date: night)
        end
        flash[:success] = "Made night(s) available!"
        redirect_to user_couch_path(current_user, couch)
      end

    rescue ActiveRecord::RecordInvalid => invalid
      flash[:danger] = invalid.message.split(':')[1].strip
      redirect_to new_couch_night_path(couch)
    end
  end

  private
    def night_params
      x = params["First Night"].split("/").join(" ")
      y = params["Last Night"].split("/").join(" ")
      first_date = Date.strptime(x, '%m %d %Y')
      last_date = Date.strptime(y, '%m %d %Y')
      (first_date..last_date).to_a
    end

end
