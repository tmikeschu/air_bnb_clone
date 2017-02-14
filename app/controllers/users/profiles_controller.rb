class Users::ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @host = User.find(params[:user_id])
  end
end
