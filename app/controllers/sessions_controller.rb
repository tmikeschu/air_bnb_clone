class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:current_user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:danger] = "Unsuccessful login attempt"
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end
end
