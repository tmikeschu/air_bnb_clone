class ReservationsController < ApplicationController
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
      params.permit("user_id")
    end

    def nights_params
      params.permit("couch_id", "check_in", "check_out")
    end
end
