#!/usr/bin/env ruby

require 'rubygems'
require 'config/environment'
require 'nokogiri'
require 'open-uri'
require 'iconv'

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

  def self.import_schedule
    htmfiles = File.join("**", "rozklady", "**", "00**t***.htm")
    files = Dir.glob(htmfiles)
    # files = ['tmp/map_rozkl/rozklady/0017/0017t046.htm'] # DEBUG
    files.each do |file|
      puts "#{file}"
      doc = Nokogiri::HTML(open(file))

      # TODO dodaj informacje z "wa¿ny od:"
      information_record = { 
        :line_number => doc.xpath("//tr/td/font/b")[0].content.strip.to_i,
        :stop_name => doc.xpath("//tr/td/a/b")[0].content.strip,
        :direction => doc.xpath("//tr/td/b")[0].content.strip  
      }

      doc.css('table').each do |table_body|
        table_body.css('tr').each do |table_row|
          table_cells = table_row.css('td')
          next unless table_cells[0].attributes.to_s == "alignCENTER"
          begin
            record = {
              :hours => table_cells[0].content,
              :working_minutes =>  table_cells[1].content.gsub('-', '').split(' '),
              :holidays_minutes => table_cells[3].content.gsub('-', '').split(' '),
              :sundays_minutes => table_cells[5].content.gsub('-', '').split(' '),
              :saturdays_minutes => table_cells[7].content.gsub('-', '').split(' ')
            }
          rescue NoMethodError
            puts "DEBUG: #{table_cells.to_s}"
            next
          end
          LineSchedule.transaction do
            record[:working_minutes].each do |minute|
              # printf "#{information_record[:line_number]} #{information_record[:stop_name]} #{information_record[:direction]} #{record[:hours]}:#{minute.to_i} "
              # if minute =~ /D/
                # printf "niskopod¿ogowy"
              # end
              # puts "\n"

              line_schedule = LineSchedule.create!(
                             :line_number => information_record[:line_number],
                             :direction => information_record[:direction],
                             :stop_name => information_record[:stop_name],
                             :arrival_time => Time.parse("#{record[:hours]}:#{minute.to_i}:00"),
                             :shedule_type => "working",
                             :low_floor => (minute =~ /D/),
                             :final_course => (minute =~ /Z/)
                           )
            end
          end
        end
      end
    end
  end

end

InitialHtmlDataExtractor.import_stations

# InitialHtmlDataExtractor.import_schedule

