class ReservationsController < ApplicationController

  before_action :require_login

  def create
    reservation = ReservationMaker.create_reservation(
       traveler: traveler_params.to_h,
       nights:   nights_params.to_h
    )
    if reservation.save
      flash[:success] = "#{reservation.couch_name} reserved for #{reservation.check_in}."
      redirect_to user_reservations_path(current_user)
    else
      flash[:danger] = reservation.errors.full_messages.join(", ")
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def traveler_params
      { "user_id" => current_user.id }
    end

    def nights_params
      params["check_in"] = params["Couch_Listing_Check_In"] if params["Couch_Listing_Check_In"]
      params["check_out"] = params["Couch_Listing_Check_Out"] if params["Couch_Listing_Check_Out"]
      params.permit("couch_id", "check_in", "check_out")
    end

    def require_login
      unless current_user
        flash[:danger] = "You must be logged in to make a reservation."
        redirect_to login_path
      end
    end
end
