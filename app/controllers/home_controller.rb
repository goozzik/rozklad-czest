class HomeController < ApplicationController
  auto_complete_for :station, :name
  def index
    @favourites = Favourite.test
    @stations = Station.all
  end
end
