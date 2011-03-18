class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :mobile_device?

  private

    def mobile_device?
      if request.user_agent =~ /Mobile|webOS/
        session[:mobile] = true
      else
        session[:mobile] = false
      end
    end

end
