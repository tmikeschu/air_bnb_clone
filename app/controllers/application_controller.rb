require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  helper_method :current_user

  private
    def current_user
      @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    end
end
