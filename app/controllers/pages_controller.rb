class PagesController < ApplicationController
  def index
  end
  
  def map
    @lat = session[:lat]
    @lng = session[:lng]
  end

  def get_location
    if params[:lat].nil?
      flash[:error] = "Nie udalo sie uzyskac twojej lokalizacji."
      render :action => pages_errors_path 
    else
      session[:lat] = params[:lat]
      session[:lng] = params[:lng]
      redirect_to root_path
    end
  end

  def errors
  end
end
