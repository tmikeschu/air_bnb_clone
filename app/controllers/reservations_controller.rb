class ReservationsController < ApplicationController
  def create
    ReservationMaker.create_reservation(
       traveler: reservation_params.to_h,
       nights: night_params.to_h
    )
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
