# coding: utf-8
class SearchScheduleController < ApplicationController
  autocomplete :station, :name, :full => true

  def search
    @schedules = Array.new
    @station_to = Station.find_by_name(params[:station_to].upcase)
    if @station_to.nil?
      flash[:error] = 'Przystanek docelowy nie istnieje.'
      render :action => pages_errors_path
    else
      # Schedules station_from to staton_to 
      if params[:from_station] == 'true'
        @station_from = Station.find_by_name(params[:station_from].upcase)
        if @station_from.nil?
          flash[:error] = 'Przystanek odjazdowy nie istnieje.'
          render :action => pages_errors_path
        else
          if Line.find_first_by_stations([@station_from.id, @station_to.id]).nil?
            flash[:error] = 'Brak połączen między przystankiem odjazdowym a docelowym.'
            render :action => pages_errors_path
          else
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
                @schedules << _schedules
              end
            else 
              unless _today_schedules.empty?
                @schedules << _today_schedules
              end
            end
          end
        end
      end

      # Schedules stations_near to station_to
      if params[:from_my_location] == 'true'
        @within = params[:within]
        @stations_near = Station.within(@within, :origin => [session[:lat], session[:lng]])
        # Delete all who dont have connect to station_to
        @stations_near.delete_if { |station| Line.find_first_by_stations([station.id, @station_to.id]).nil? } 
        @stations_near.each do |station|
          lines = Line.find_all_by_stations([station.id, @station_to.id])
          _today_schedules = Schedule.all(
            :conditions => ["line_id IN (?)
              AND station_id = ?
              AND arrival_at > ?
              AND sunday = ?
              AND saturday = ?
              AND work = ?",
              lines.collect(&:id),
              station.id,
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
                station.id,
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
              @schedules << _schedules
            end
          else 
            unless _today_schedules.empty?
              @schedules << _today_schedules
            end
          end
        end
      end 
    end
  end

  def map
    @lat = session[:lat]
    @lng = session[:lng]
    @station_from = Station.find(params[:station_from])
    @station_to = Station.find(params[:station_to])
    @map = params[:map]
  end
end
