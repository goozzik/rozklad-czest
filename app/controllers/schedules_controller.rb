class SchedulesController < ApplicationController

  def stations
    @stations_ordered = Station.paginate_by_letter
  end

  def station
  end

  def road
  end

  def schedule
  end

end
