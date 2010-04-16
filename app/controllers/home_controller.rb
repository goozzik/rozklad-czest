class HomeController < ApplicationController

  def index
    @time = Time.now.strftime("%H:%M")
    @favourites = Favourite.test
  end
end
