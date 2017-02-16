class MessagesController < ApplicationController
  before_action :authorize_user

  def create
    reservation = Reservation.find(params[:reservation_id])
    @message = reservation.messages.new(content: params[:message][:content], author: current_user)
    flash[:danger] = "Message content can't be blank" unless @message.save
    redirect_to user_reservation_path(current_user, reservation)
  end
end
