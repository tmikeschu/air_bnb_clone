class ConfirmationsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:confirmations][:email])
    if @user.verification_code == params[:confirmations][:verification_code]
      @user.save!
      session[:authenticated] = true

      flash[:notice] = "Welcome #{@user.first_name}. The Adventure Begins!"
      redirect_to edit_password_reset_path(@user)
    else
      flash.now[:alert] = "Verification code is incorrect."
      render :new
    end
  end
end
