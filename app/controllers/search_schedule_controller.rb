# coding: utf-8
class SearchScheduleController < ApplicationController

  autocomplete :station, :name, :full => true

  def search
    @schedules = []
    if params[:to] == 'station'
      if @station_to = Station.find_by_name(params[:station_to].upcase)
        if params[:from] == 'station'
          if @station_from = Station.find_by_name(params[:station_from].upcase)
            if Line.find_first_by_stations(@station_from.id, @station_to.id) 
              @schedules << Schedule.get(@station_from.id, @station_to.id)
            else
              flash[:error] = 'Brak połączeń.'
              render :template => pages_info_path
            end
          else
            flash[:error] = 'Przystanek odjazdowy nie istnieje.'
            render :template => pages_info_path
          end
        end

        if params[:from] == 'location'
          if my_location = [session[:lat], session[:lng]]
            within = params[:within].gsub(',', '').to_f / 1000
            stations_near = Station.within(within, :origin => my_location).order('distance asc')
            unless stations_near.delete_if { |station| Line.find_first_by_stations(station.id, @station_to.id).nil? }.empty?
              stations_near.each { |station| @schedules << Schedule.get(station.id, @station_to.id) }
            else
              flash[:error] = 'Nie znaleziono przystanku w pobliżu.'
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
    end

    if params[:to] == 'location'
      location = Geokit::Geocoders::GoogleGeocoder.geocode(params[:location_to])
      if location.success
        stations_to = Station.within(0.5, :origin => [location.lat, location.lng]).order('distance asc')
        unless stations_to.empty?
          if params[:from] == 'station'
            if @station_from = Station.find_by_name(params[:station_from].upcase)
              if @station_to = stations_to.delete_if { |station| Line.find_first_by_stations(@station_from.id, station.id).nil? }.first
                @schedules << Schedule.get(@station_from.id, @station_to.id)
              else
                flash[:error] = 'Brak połączeń.'
                render :template => pages_info_path
              end
            else
              flash[:error] = 'Przystanek odjazdowy nie istnieje.'
              render :template => pages_info_path
            end
          end

          if params[:from] == 'location'
            if my_location = [session[:lat], session[:lng]]
              within = params[:within].gsub(',', '').to_f / 1000
              stations_near = Station.within(within, :origin => my_location).order('distance asc')
              unless stations_near.empty?
                stations_to.each do |station_to|
                  stations_near.each do |station_from|
                    if Line.find_first_by_stations(station_from.id, station_to.id)
                      @station_to = station_to 
                      break
                    end
                  end
                  break if @station_to
                end
                if @station_to
                  stations_near.delete_if { |station| Line.find_first_by_stations(station.id, @station_to.id).nil? }
                  stations_near.each { |station| @schedules << Schedule.get(station.id, @station_to.id) }
                else
                  flash[:error] = 'Brak połączeń między znalezionymi przystankami.'
                  render :template => pages_info_path
                end
              else
                flash[:error] = 'Nie znaleziono przystanku w pobliżu.'
                render :template => pages_info_path
              end
            else
              flash[:error] = 'Nie udostępniono położenia.'
              render :template => pages_info_path
            end
          end
        else
          flash[:error] = 'Nie znaleziono przystanku w pobliżu danego adresu.'
          render :template => pages_info_path
        end
      else
        flash[:error] = 'Nie znaleziono adresu.'
        render :template => pages_info_path
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
