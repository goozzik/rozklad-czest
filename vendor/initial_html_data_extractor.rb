#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require './config/environment'
require 'nokogiri'
require 'open-uri'
require 'iconv'

DEBUG = true

class InitialHtmlDataExtractor

  def self.import_stations
    system("rake db:import:stations")
  end

  def self.import_lines
    doc = Nokogiri::HTML(open('http://mpk.czest.pl/int_rozkl/linie.htm'))
    htmfiles = []
    doc.xpath("//html/body/center/table/tr[*]/td[*]/font/a/@href").map(&:content).each do |line|
      next if line =~ /new|mapa|przystan/
      htmfiles.push line
    end
    puts "Processing files: "
    htmfiles.each do |file|
      system("echo -n .")
      doc = Nokogiri::HTML(open('http://mpk.czest.pl/int_rozkl/' + file))
      number = doc.xpath("//html/body/table/tr/td/font/b").first.content.gsub("Linia ", "")
      directions = doc.xpath("//html/body/table/tr[2]/td[*]")
      directions.each_with_index do |direction, n|
        _direction = direction.content.gsub("kierunek:", "").strip
        _stations = []
        stations = doc.xpath("//html/body/table/tr[3]/td[#{n+1}]/ul/li[*]")
        stations.each do |station|
          _station = station.content
          if _station == 'TEATR im. A. MICKIEWICZA'
            _station = 'TEATR IM. A. MICKIEWICZA' 
          end
          station = Station.find_by_name(_station)
          _stations << station unless station.nil?
        end
        Line.create!(
          :number => number,
          :direction => _direction,
          :stations => _stations
        )
      end
    end
  end
  
  def self.import_schedules
    doc = Nokogiri::HTML(open('http://mpk.czest.pl/int_rozkl/linie.htm'))
    _htmfiles = []
    htmfiles = []
    doc.xpath("//html/body/center/table/tr[*]/td[*]/font/a/@href").map(&:content).each do |line|
      next if line =~ /new|mapa|przystan/
      _htmfiles.push line
    end
    _htmfiles.each do |_file|
      doc = Nokogiri::HTML(open('http://mpk.czest.pl/int_rozkl/' + _file))
      doc.xpath("//html/body/table/tr[3]/td/ul/li[*]/a/@href").map(&:content).each do |file|
        htmfiles.push file.gsub('r', 't')
      end
    end
    htmfiles.each do |file|
      doc = Nokogiri::HTML(open('http://mpk.czest.pl/int_rozkl/rozklady/' + file[0..3] + '/' + file))
      number = doc.xpath("//html/body/table/tr/td/font/b").first.content.strip
      direction = doc.xpath("//html/body/table/tr/td/b").first.content.strip
      station = doc.xpath("//html/body/table/tr/td/a/b").first.content
      if station == 'TEATR im. A. MICKIEWICZA'
        station = 'TEATR IM. A. MICKIEWICZA' 
      end

      # TODO
      # Remove rescue next
      # Problem : 14 has 6 directions :/
      line_id = Line.find_by_number_and_direction(number, direction).id rescue next
      station_id = Station::Import.get_id_by_name_if_exist(station)

      # Robocze /html/body/table/tbody/tr[4]/td/b
      works = doc.xpath("//html/body/table/tr/td[1]/b").each_with_index do |work, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[2]").first.content.gsub('-', '').split(" ")
        # TODO legend letters
        
        minutes.each do |minute|
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, work.content.to_i, minute.to_i, 0),
            :work => true
          )
        end
      end

      # Wakacyjne /html/body/table/tbody/tr[4]/td[3]/b
      holidays = doc.xpath("//html/body/table/tr/td[3]/b").each_with_index do |holiday, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[4]").first.content.gsub('-', '').split(" ")

        minutes.each do |minute|
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, holiday.content.to_i, minute.to_i, 0),
            :holiday => true
          )
        end
      end

      # Soboty    /html/body/table/tbody/tr[4]/td[5]/b
      saturdays = doc.xpath("//html/body/table/tr/td[5]/b").each_with_index do |saturday, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[6]").first.content.gsub('-', '').split(" ")

        minutes.each do |minute|
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, saturday.content.to_i, minute.to_i, 0),
            :saturday => true
          )
        end
      end

      # Niedziele /html/body/table/tbody/tr[4]/td[7]/b
      sundays = doc.xpath("//html/body/table/tr/td[7]/b").each_with_index do |sunday, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[8]").first.content.gsub('-', '').split(" ")

        minutes.each do |minute|
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, sunday.content.to_i, minute.to_i, 0),
            :sunday => true
          )
        end
      end
    end

    #raise "OK"

    #schedule = Schedule.create!(
                #:line_id = line_id,
                #:station_id = station_id,
                #:time => Time.parse("#{record[:hours]}:#{minute.to_i}:00"),
                #:work => true,
                #:saturday => false,
                #:sunday => false,
                #:summer => false
              #)
  end

end



case ARGV.first
  when 'extract'
    InitialHtmlDataExtractor.import_stations
    InitialHtmlDataExtractor.import_lines
    InitialHtmlDataExtractor.import_schedules
  
  when 'test'
    station_from = Station.find_by_name("RYNEK WIELUŃSKI")
    puts "From: #{station_from.inspect}"

    station_to = Station.find_by_name("II ALEJA NAJŚWIĘTSZEJ MARYI PANNY")
    puts "To: #{station_to.inspect}"

    puts

    lines = Line.find_all_by_stations([station_from.id, station_to.id])
    puts "Lines #{lines.inspect}"

    puts

    schedules = Schedule.all(
      :conditions => ["line_id IN (?) AND station_id = ? AND arrival_at > ?", lines.collect(&:id), station_from.id, Time.now],
      :order => "arrival_at",
      :limit => 5
    )

    puts "Schedule:"
    schedules.each do |schedule|
      puts "#{schedule.line.number} #{schedule.line.direction} at #{schedule.arrival_at.strftime("%H:%M")}"
    end

  else
    puts "Usage: initial_html_data_extractor.rb {extract|test}"
end
