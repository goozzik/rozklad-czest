#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'config/environment'
require 'nokogiri'
require 'open-uri'
require 'iconv'

DEBUG = true

class InitialHtmlDataExtractor

  def self.import_stations
    file = File.join(Rails.root, "tmp", "map_rozkl", "rozklady", "przystan.htm")
    doc = Nokogiri::HTML(open(file))
    doc.xpath("//html/body/table/tr[*]/td/ul/li/a").each do |station|
      Station.create!(
        :name => station.content
      )
    end
  end

  def self.import_lines
    htmfiles = File.join("**", "rozklady", "**", "w.htm")
    files = Dir.glob(htmfiles)
    files.each do |file|
      puts "File: #{file}"
      doc = Nokogiri::HTML(open(file))
      number = doc.xpath("//html/body/table/tr/td/font/b").first.content.gsub("Linia ", "")
      puts "Number: #{number}"
      directions = doc.xpath("//html/body/table/tr[2]/td[*]")
      directions.each_with_index do |direction, n|
        _direction = direction.content.gsub("kierunek:", "").strip
        puts "Direction: #{_direction}"
        _stations = []
        stations = doc.xpath("//html/body/table/tr[3]/td[#{n+1}]/ul/li[*]")
        stations.each do |station|
          _station = station.content
          puts "Station: #{_station}"
          _stations << Station.find_by_name(_station).id
        end
        Line.create!(
          :number => number,
          :direction => _direction,
          :stations => _stations
        )
      end
    end
  end

  def self.import_schedule
    htmfiles = File.join("**", "rozklady", "**", "00**t***.htm")
    files = Dir.glob(htmfiles)
    files.each do |file|
      pd "#{file}"
      doc = Nokogiri::HTML(open(file))

      number = doc.xpath("//html/body/table/tr/td/font/b").first.content.strip
      direction = doc.xpath("//html/body/table/tr/td/b").first.content.strip
      station = doc.xpath("//html/body/table/tr/td/a/b").first.content

      pd "Number: #{number}"
      pd "Direction: #{direction}"

      # TODO
      # Remove rescue next
      # Problem : 14 has 6 directions :/
      line_id = Line.find_by_number_and_direction(number, direction).id rescue next
      station_id = Station.find_by_name(station).id

      # Robocze /html/body/table/tbody/tr[4]/td/b
      #         /html/body/table/tbody/tr[5]/td/b
      works = doc.xpath("//html/body/table/tr/td[1]/b").each_with_index do |work, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[2]").first.content.gsub('-', '').split(" ")
        # TODO legend letters
        
        pd "Hour: #{work.content}"
        pd "Minutes: #{minutes.inspect}"

        minutes.each do |minute|
          pd "Arrive at: #{work.content}:#{minute.to_i}:00"
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.parse("#{work.content}:#{minute.to_i}:00"),
            :work => true
          )
        end
      end

      # raise ":)"
      # Wakacyjne /html/body/table/tbody/tr[4]/td[3]/b
      # Soboty    /html/body/table/tbody/tr[4]/td[5]/b
      # Niedziele /html/body/table/tbody/tr[4]/td[7]/b
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

  private

    def self.pd(msg)
      puts "DEBUG: #{msg}" if DEBUG == true
    end

end



case ARGV.first
  when 'extract'
    InitialHtmlDataExtractor.import_stations
    InitialHtmlDataExtractor.import_lines

    station = Station.find_by_name('TEATR im. A. MICKIEWICZA')
    if not station.nil? then
      station.name = station.name.upcase
      station.save()
    end

    InitialHtmlDataExtractor.import_schedule
  
  def test
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
  end

end
