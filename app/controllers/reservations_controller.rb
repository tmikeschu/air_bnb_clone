class ReservationsController < ApplicationController
  def create
    reservation = Reservation.new(reservation_params)
    reservation.confirmed!
    nights = Night.where(couch_id: night_params["couch_id"]).where(date: Date.parse(params["check_in"])..Date.parse(params["check_out"]) - 1.day)
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
