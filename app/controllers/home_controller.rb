class HomeController < ApplicationController

  def index
    @favourites = Favourite.test
  end
  
end
