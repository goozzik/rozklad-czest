class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :current_user
  before_filter :mobile_device?

  private

    def mobile_device?
      if request.user_agent =~ /Mobile|webOS/
        session[:mobile] = true
      else
        session[:mobile] = false
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

end
