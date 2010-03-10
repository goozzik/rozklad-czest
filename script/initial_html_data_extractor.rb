#!/usr/bin/env ruby

require 'rubygems'

require 'nokogiri'
require 'open-uri'
require 'iconv'

ICONV_TO = 'UTF-8'
ICONV_FROM = 'ISO-8859-2'

# doc = Nokogiri::HTML(open("/Users/hash4di/Downloads/mpk_rozkl/rozklady/0019/0019t049.htm"))
doc = Nokogiri::HTML(open("/Users/hash4di/Downloads/mpk_rozkl/rozklady/0019/0019t049.htm")).each

  
  doc.css('table').each do |table_body|
    table_body.css('tr')[3..22].each do |table_row|
      table_cells = table_row.css('td')

      record = { :hours => table_cells[0].content,
                 :working_minutes =>  table_cells[1].content.gsub('-', '').split(' '),
                 :holidays_minutes => table_cells[3].content.gsub('-', '').split(' '),
                 :sundays_minutes => table_cells[5].content.gsub('-', '').split(' '),
                 :saturdays_minutes => table_cells[7].content.gsub('-', '').split(' ')
               }
               
      # record[:holidays_minutes].size
      puts record.inspect         
    end
  end
