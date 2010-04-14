class HomeController < ApplicationController

  def index
    @time = Time.now
    @favourites = Favourite.test
  end
end
