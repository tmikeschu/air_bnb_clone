class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:password_resets][:email])
    if @user
      ConfirmationSender.send_confirmation_to(@user)
      redirect_to new_confirmation_path
    else
      flash[:danger] = "Email not found"
      redirect_to new_password_reset_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].empty?
      flash[:danger] = "Password cannot be empty"
      render :edit
    elsif @user.update_attributes(user_params)
      flash[:success] = "Password has been reset"
      redirect_to login_path
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
