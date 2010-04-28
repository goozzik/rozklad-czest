class HomeController < ApplicationController

  def index
    @time = Time.now.strftime("%H:%M")
    @favourites = Favourite.test
    @remaining_time = @favourites.first.arrival_at - Time.now
    
  end
end
