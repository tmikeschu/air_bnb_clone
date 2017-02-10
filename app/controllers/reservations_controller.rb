class ReservationsController < ApplicationController
  def create
    reservation = Reservation.new(reservation_params)
    reservation.confirmed!
    nights = Night.all_for_couch(night_params["couch_id"]).between_check_in_check_out(night_params["check_in"], night_params["check_out"])
    reservation.nights << nights
    reservation.save
    flash[:success] = "#{Couch.find(params["couch_id"]).name} reserved for #{params["check_in"]}."
    redirect_to user_reservations_path(current_user)
  end

  private

    def reservation_params
      params.permit("user_id")
    end

    def night_params
      params.permit("couch_id", "check_in", "check_out")
    end
end
