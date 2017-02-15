class Users::ReservationsController < UsersController
  before_action :verify_user, only: [:index]

  def index
    @reservations = current_user.reservations
  end

  private

    def verify_user
      render file: "public/404", status: 404 unless current_user && current_user.id == params["user_id"].to_i
    end
end
