# coding: utf-8
class SearchScheduleController < ApplicationController

  autocomplete :station, :name, :full => true

  def search
    if params[:to] == 'station'
      if @station_to = Station.find_by_name(params[:station_to].upcase)
        if params[:from] == 'station'
          if @station_from = Station.find_by_name(params[:station_from].upcase)
            if Line.find_first_by_stations(@station_from.id, @station_to.id)
              @schedules = [Schedule.get(@station_from.id, @station_to.id)]
            else
              flash[:error] = 'Brak połączeń.'
              render :template => pages_info_path
            end
          else
            flash[:error] = 'Przystanek odjazdowy nie istnieje.'
            render :template => pages_info_path
          end
        else
          if my_location = [session[:lat], session[:lng]]
            @schedules = Schedule.get_by_near_stations_and_station_to(params[:within], my_location, @station_to.id)
            if @schedules.empty?
              flash[:error] = 'Brak połączeń.'
              render :template => pages_info_path
            end
          else
            flash[:error] = 'Nie udostępniono położenia.'
            render :template => pages_info_path
          end
        end
      else
        flash[:error] = 'Przystanek docelowy nie istnieje.'
        render :template => pages_info_path
      end
    else
      if params[:from] == 'station'
        if @station_from = Station.find_by_name(params[:station_from].upcase)
          @schedules = Schedule.get_by_station_from_and_location(@station_from.id, params[:location_to])
          if @schedules.empty?
            flash[:error] = 'Brak połączeń.'
            render :template => pages_info_path
          end
        else
          flash[:error] = 'Przystanek odjazdowy nie istnieje.'
          render :template => pages_info_path
        end
      else
        if my_location = [session[:lat], session[:lng]]
          @schedules = Schedule.get_by_near_stations_and_location(params[:within], my_location, params[:location_to])
          if @schedules.empty?
            flash[:error] = 'Brak połączeń.'
            render :template => pages_info_path
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
      flash[:error] = 'Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnić swoje położenie.'
      render :template => pages_info_path
    end
  end

end
