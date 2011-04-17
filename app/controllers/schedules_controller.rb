class SchedulesController < ApplicationController

  def stations
    @stations_ordered = Station.paginate_by_letter
  end

  def station
    @station = Station.find(params[:id])
    @lines = @station.lines
  end

  def lines
    @lines = Line.get_numbers
  end

  def line
    @number = params[:number]
    @lines = Line.where(:number => @number)
  end

  def line_road 
    @line = Line.find(params[:id])
    @stations = @line.stations
  end

  def schedule
  end

end
