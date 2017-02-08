class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:current_user] = user.id
      redirect_to user_path(user)
    else
      flash[:danger] = "you done fucked up"
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    flass[:success] = "Successfully logged out!"
    redirect_to root_path
  end
end