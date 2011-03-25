class PagesController < ApplicationController

  def index
    @favourites = Favourite.all(:conditions => ['on_start_page = ?', true])
  end
  
  def static_map
    @lat = session[:lat]
    @lng = session[:lng]
  end

  def get_location
    if params[:lat].nil?
      flash[:error] = "Nie udalo sie uzyskac twojej lokalizacji."
      render :template => pages_errors_path 
    else
      session[:lat] = params[:lat]
      session[:lng] = params[:lng]
      redirect_to root_path
    end
  end

  def errors
  end

end
