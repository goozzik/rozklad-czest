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

  def line_road_map
    @line_map_url = Line.find(params[:id]).map_url
  end

  def schedule
    @schedules_work = Schedule.paginate_by_hour(params[:line_id], params[:station_id], :work)
    @schedules_sunday = Schedule.paginate_by_hour(params[:line_id], params[:station_id], :sunday)
    @schedules_saturday = Schedule.paginate_by_hour(params[:line_id], params[:station_id], :saturday)
    @schedules_holiday = Schedule.paginate_by_hour(params[:line_id], params[:station_id], :holiday)
  end

end
