class ConfirmationsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:confirmations][:email])
    if @user.verification_code == params[:confirmations][:verification_code]
      @user.save!
      session[:authenticated] = true

      flash[:success] = "Verification success!"
      redirect_to edit_password_reset_path(@user)
    else
      flash.now[:danger] = "Verification code is incorrect."
      render :new
    end
  end
end
