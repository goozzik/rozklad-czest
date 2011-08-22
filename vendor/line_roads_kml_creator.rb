# This script is for creating line roads file for google static map.
# Usage: ruby line_roads_kml_creator
require 'rubygems'
require './config/environment'
require 'nokogiri'
require 'open-uri'
require 'iconv'

Line.all.each do |line|
  File.open("vendor/kml_files/line_road_#{line.id}_coords.kml", 'w') do |f|
    f.puts '<?xml version="1.0" encoding="UTF-8"?>'
    f.puts '<kml xmlns="http://earth.google.com/kml/2.2">'
    f.puts '  <Document>'
    f.puts "    <name>#{line.number} #{line.direction}</name>"
    f.puts '    <LookAt>'
    f.puts '      <latitude>50.817405</latitude>'
    f.puts '      <longitude>19.118485</longitude>'
    f.puts '      <range>5000000</range>'
    f.puts '      <tilt>0</tilt>'
    f.puts '      <heading>0</heading>'
    f.puts '    </LookAt>'
    f.puts "    <Placemark>"
    f.puts "      <name>#{line.number} #{line.direction}</name>"
    f.puts "      <LineString>"
    f.puts "        <extrude>1</extrude>"
    f.puts "        <tessellate>1</tessellate>"
    f.puts "        <altitudeMode>absolute</altitudeMode>"
    f.puts "        <coordinates>"
    line.stations.each_with_index do |station,i|
      f.puts "          #{station.lng},#{station.lat},#{i+1}"
    end
    f.puts "        </coordinates>"
    f.puts "      </LineString>"
    f.puts "    </Placemark>"
    line.stations.each_with_index do |station,i|
      f.puts "    <Placemark>"
      f.puts "      <name>#{station.name} (#{i+1})</name>"
      f.puts "      <Point>"
      f.puts "        <coordinates>#{station.lng},#{station.lat}</coordinates>"
      f.puts "      </Point>"
      f.puts "    </Placemark>"
      puts "Create placemarker for #{station.name}"
    end
    f.puts '  </Document>'
    f.puts '</kml>'
    puts "Create road for #{line.number} #{line.direction}"
  end
end
