class MessagesController < ApplicationController
  before_action :authorize_user

  def create
    reservation = Reservation.find(params[:reservation_id])
    @message = reservation.messages.new(content: params[:message][:content], author: current_user)
    if @message.save
      ActionCable.server.broadcast('room_channel',
                                   content: @message.content,
                                   author_name: current_user.author_name)
      head :ok
    end
  end
end
