# coding: utf-8
class FavouritesController < ApplicationController
  def index
    @favourites = Favourite.all
  end

  def show
    @favourite = Favourite.find(params[:id])
    @station_from = Station.find_by_name(@favourite.station_from)
    @station_to = Station.find_by_name(@favourite.station_to)
    lines = Line.find_all_by_stations([@station_from.id, @station_to.id])
    _today_schedules = Schedule.all(
      :conditions => ["line_id IN (?)
        AND station_id = ?
        AND arrival_at > ?
        AND sunday = ?
        AND saturday = ?
        AND work = ?",
        lines.collect(&:id),
        @station_from.id,
        Time.now + 3600,
        Time.now.wday == 0 ? true : false,
        Time.now.wday == 6 ? true : false,
        (Time.now.wday != 6 and Time.now.wday != 0) ? true : false
      ],
      :order => 'arrival_at',
      :limit => 10
    )
    if _today_schedules.count < 10
      limit = 10 - _today_schedules.count
      _next_day_schedules = Schedule.all(
        :conditions => ["line_id IN (?)
          AND station_id = ?
          AND arrival_at > ?
          AND sunday = ?
          AND saturday = ?
          AND work = ?",
          lines.collect(&:id),
          @station_from.id,
          (Date.today + 1).to_time + 3600,
          ((Date.today + 1).to_time + 3600).wday == 0 ? true : false,
          ((Date.today + 1).to_time + 3600).wday == 6 ? true : false,
          (((Date.today + 1).to_time + 3600).wday != 6 and ((Date.today + 1).to_time + 3600).wday != 0) ? true : false
        ],
        :order => 'arrival_at',
        :limit => limit 
      )
    end
    unless _next_day_schedules.nil?
      _schedules = _today_schedules + _next_day_schedules
      unless _schedules.empty?
        @schedules = _schedules
      end
    else 
      unless _today_schedules.empty?
        @schedules = _today_schedules
      end
    end
  end

  def new
    @favourite = Favourite.new
  end

  def create
    @favourite = Favourite.new(params[:favourite])
    station_from = Station.find_by_name(@favourite.station_from.upcase)
    station_to = Station.find_by_name(@favourite.station_to.upcase)
    if station_from.nil? or station_to.nil?
      flash[:error] = 'Przystanek odjazdowy nie istnieje.'
      render :action => pages_errors_path 
    else
      if Line.find_first_by_stations([station_from.id, station_to.id]).nil?
        flash[:error] = 'Brak połączeń.'
        render :action => pages_errors_path 
      else
        @favourite.station_from.upcase! 
        @favourite.station_to.upcase! 
        @favourite.save
        redirect_to favourites_url
      end
    end
  end

  def edit
    @favourite = Favourite.find(params[:id])
  end

  def update
    @favourite = Favourite.find(params[:id])
    @edited_fav = Favourite.new(params[:favourite])
    station_from = Station.find_by_name(@edited_fav.station_from.upcase)
    station_to = Station.find_by_name(@edited_fav.station_to.upcase)
    if station_from.nil? or station_to.nil?
      flash[:error] = 'Jeden z przystanków nie istnieje.'
      render :action => pages_errors_path 
    else
      if Line.find_first_by_stations([station_from.id, station_to.id]).nil?
        flash[:error] = 'Brak połączen między przystankiem odjazdowym a docelowym.'
        render :action => pages_errors_path 
      else
        @edited_fav.station_from.upcase!
        @edited_fav.station_to.upcase!
        @favourite.update_attributes(@edited_fav)
        redirect_to favourites_url 
      end
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_to favourites_url
  end
end
