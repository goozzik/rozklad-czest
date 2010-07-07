class HomeController < ApplicationController

  def index
    @favourites = Favourite.test
  end
  
  def find_schedule
    station_from = Station.find_by_name("#{params[:find_from]}")
    station_to = Station.find_by_name("#{params[:find_to]}")
    lines = Line.find_all_by_stations([station_from.id, station_to.id])
    @schedules = Schedule.all(
           :conditions => ["line_id IN (?) AND station_id = ? AND arrival_at > ?", lines.collect(&:id), station_from.id, Time.now],
           :order => "arrival_at",
           :limit => 5
         )
  end

end
