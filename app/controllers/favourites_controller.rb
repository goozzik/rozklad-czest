class FavouritesController < ApplicationController
  def index
    @favourites = Favourite.all
  end

  def show
    @favourite = Favourite.find(params[:id])
    @station_from = Station.find_by_name(@favourite.station_from)
    @station_to = Station.find_by_name(@favourite.station_to)
    lines = Line.find_all_by_stations([@station_from.id, @station_to.id])
    @schedules = Schedule.all(
      :conditions => ["line_id IN (?) AND station_id = ? AND arrival_at > ? AND sunday = ? AND saturday = ? AND work = ?",
        lines.collect(&:id), @station_from.id, Time.now + 3600,
        Time.now.wday == 0 ? true : false,
        Time.now.wday == 6 ? true : false,
        Time.now.wday != (6 or 0) ? true : false
      ],
      :order => "arrival_at",
      :limit => 10
    )
  end

  def new
    @favourite = Favourite.new
  end

  def create
    @favourite = Favourite.new(params[:favourite])
    station_from = Station.find_by_name(@favourite.station_from.upcase)
    station_to = Station.find_by_name(@favourite.station_to.upcase)
    if station_from.nil? or station_to.nil?
      flash[:error] = "Jedna z podanych stacji nie istnieje."
      render :action => "new" 
    else
      if Line.find_first_by_stations([station_from.id, station_to.id]).nil?
        flash[:error] = "Brak polaczen."
        render :action => "new" 
      else
        @favourite.station_from.upcase! 
        @favourite.station_to.upcase! 
        if @favourite.save
          flash[:notice] = "Dodano pomyslnie."
          redirect_to favourites_url 
        end
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
      flash[:error] = "Jedna z podanych stacji nie istnieje."
      render :action => "edit" 
    else
      if Line.find_first_by_stations([station_from.id, station_to.id]).nil?
        flash[:error] = "Brak polaczen."
        render :action => "edit" 
      else
        @edited_fav.station_from.upcase!
        @edited_fav.station_to.upcase!
        if @favourite.update_attributes(@edited_fav)
          flash[:notice] = "Zapisano pomyslnie."
          redirect_to favourites_url 
        end
      end
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    if @favourite.destroy
      flash[:notice] = "Usunieto pomyslnie."
      redirect_to favourites_url
    end
  end
end
