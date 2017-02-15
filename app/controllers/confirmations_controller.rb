class ConfirmationsController < ApplicationController
  def new
    @user = User.find(session[:current_user_id])
  end

  def create
    @user = User.find(session[:current_user_id])
    if @user.verification_code == params[:user][:verification_code]
      @user.save!
      session[:authenticated] = true

      flash[:notice] = "Welcome #{@user.first_name}. The Adventure Begins!"
      redirect_to root_path
    else
      flash.now[:alert] = "Verification code is incorrect."
      render :new
    end
  end
end
