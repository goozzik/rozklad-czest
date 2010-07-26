require 'rubygems'
require 'config/environment'
require 'nokogiri'
require 'open-uri'
require 'iconv'
require 'tools/initial_html_data_extractor'

class SearchScheduleController < ApplicationController
  def find_schedule
    station_from = Station.find_by_name("#{params[:finder_from]}")
    station_to = Station.find_by_name("#{params[:finder_to]}")
    lines = Line.find_all_by_stations([station_from.id, station_to.id])
    @schedules = Schedule.all(
           :conditions => ["line_id IN (?) AND station_id = ? AND arrival_at > ?", lines.collect(&:id), station_from.id, Time.now],
           :order => "arrival_at",
           :limit => 5
         )
  end

end
