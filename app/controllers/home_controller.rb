class HomeController < ApplicationController

  def index
    @favourites = Favourite.test
    @stations = Station.all
  end
end
