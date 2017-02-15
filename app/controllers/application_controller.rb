class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: "Not authorized" } }
  end

  private
    def current_user
      @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    end
end
