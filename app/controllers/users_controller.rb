require './lib/confirmation_sender'
class UsersController < ApplicationController
  before_action :verify_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:current_user_id] = user.id
      ConfirmationSender.send_confirmation_to(user)
      redirect_to new_confirmation_path
      # redirect_to user_path(user)
    else
      flash[:danger] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def show
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
    end

    def verify_user
      render file: "public/404", status: 404 unless current_user && current_user.id == params["id"].to_i
    end
end
