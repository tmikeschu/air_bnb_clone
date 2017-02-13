class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:current_user_id] = user.id
      redirect_to user_path(user)
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
end
