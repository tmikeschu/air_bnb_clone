class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authorize_user
    render file: "public/404", status: 404 unless current_user
  end

  private
    def current_user
      @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    end
end
