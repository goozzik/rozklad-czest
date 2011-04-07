# coding: utf-8
class SearchScheduleController < ApplicationController

  autocomplete :station, :name, :full => true

  def search
    @schedules = []
    @station_to = Station.find_by_name(params[:station_to].upcase)
    if @station_to.nil?
      flash[:error] = 'Przystanek docelowy nie istnieje.'
      render :template => pages_info_path
    else
      if params[:from_station] == 'true'
        @station_from = Station.find_by_name(params[:station_from].upcase)
        if @station_from.nil?
          flash[:error] = 'Przystanek odjazdowy nie istnieje.'
          render :template => pages_info_path
        else
          if Line.find_first_by_stations([@station_from.id, @station_to.id]).nil?
            flash[:error] = 'Brak połączeń.'
            render :template => pages_info_path
          else
            @schedules << Schedule.get(@station_from.id, @station_to.id)
          end
        end
      end
      if params[:from_my_location] == 'true'
        unless session[:lat].nil?
          stations_near = Station.within(params[:within], :origin => [session[:lat], session[:lng]])
          stations_near.delete_if { |station| Line.find_first_by_stations([station.id, @station_to.id]).nil? } 
          stations_near.each do |station|
            @schedules << Schedule.get(station.id, @station_to.id)
          end
        else 
          flash[:error] = 'Nie udostępniono położenia.'
          render :template => pages_info_path
        end
      end
    end
  end

  def map
    @lat = session[:lat]
    @lng = session[:lng]
    @station_from = Station.find(params[:station_from])
    @station_to = Station.find(params[:station_to])
    unless @lat
      flash[:error] = 'Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnic swoje położenie.'
      render :template => pages_info_path
    end
  end

end
