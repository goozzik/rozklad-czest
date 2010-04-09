class HomeController < ApplicationController

  def index
     @from = Station.find_by_name("I ALEJA NAJŚWIĘTSZEJ MARYI PANNY")
     @to = Station.find_by_name("RYNEK WIELUŃSKI")
     @lines = Line.find_all_by_stations([station_from.id, station_to.id])
     @schedules = Schedule.all(
       :conditions => ["line_id IN (?) AND station_id = ? AND arrival_at > ?", lines.collect(&:id), station_from.id, Time.now],
       :order => "arrival_at",
       :limit => 5
     )
  end

end
