class SchedulesController < ApplicationController

  def stations
    @stations_ordered = Station.paginate_by_letter
  end

  def station
    @station = Station.find(params[:id])
    @lines = @station.lines
  end

  def road
  end

  def schedule
  end

end
