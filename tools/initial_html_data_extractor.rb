#!/usr/bin/env ruby

require 'rubygems'

require 'nokogiri'
require 'open-uri'
require 'iconv'

doc = Nokogiri::HTML(open("#{RAILS_ROOT}/tools/0019t009.htm"))

# TODO dodaj informacje z "wa¿ny od:"
information_record = { 
  :line_number => doc.xpath("//tr/td/font/b")[0].content.strip.to_i,
  :stop_name => doc.xpath("//tr/td/a/b")[0].content.strip,
  :direction => doc.xpath("//tr/td/b")[0].content.strip  
}
    
doc.css('table').each do |table_body|
  table_body.css('tr')[3..19].each do |table_row|
    table_cells = table_row.css('td')
    record = {
      :hours => table_cells[0].content,
      :working_minutes =>  table_cells[1].content.gsub('-', '').split(' '),
      :holidays_minutes => table_cells[3].content.gsub('-', '').split(' '),
      :sundays_minutes => table_cells[5].content.gsub('-', '').split(' '),
      :saturdays_minutes => table_cells[7].content.gsub('-', '').split(' ')
    }

    LineSchedule.transaction do
      record[:working_minutes].each do |minute|
        printf "#{information_record[:line_number]} #{information_record[:stop_name]} #{information_record[:direction]} #{record[:hours]}:#{minute.to_i} "
        if minute =~ /D/
          printf "niskopod¿ogowy"
        end
        puts "\n"

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

