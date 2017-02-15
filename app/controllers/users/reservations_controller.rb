class Users::ReservationsController < UsersController
  before_action :verify_user, only: [:index]

  def index
    @travel_reservations = current_user.reservations
    @host_reservations = Reservation.host_reservations(current_user)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @messages = @reservation.messages.by_created_at
    @message = Message.new
  end

  private

    def verify_user
      render file: "public/404", status: 404 unless current_user && current_user.id == params["user_id"].to_i
    end
end
