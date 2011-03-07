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
      render root_path
    else
      session[:lat] = params[:lat]
      session[:lng] = params[:lng]
      flash[:notice] = "Twoja lokalizacja zostala udostepniona."
      redirect_to root_path
    end
  end
end
