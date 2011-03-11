# This script is for creating markers file for google static map.
# Usage: ruby stations_kml_creator
require 'rubygems'
require './config/environment'
require 'nokogiri'
require 'open-uri'
require 'iconv'

File.open('vendor/stations_coords.kml', 'w') do |f|
  f.puts '<?xml version="1.0" encoding="UTF-8"?>'
  f.puts '<kml xmlns="http://earth.google.com/kml/2.2">'
  f.puts '  <Document>'
  f.puts '    <name>rozklad.czest.pl</name>'
  f.puts '    <LookAt>'
  f.puts '      <latitude>50.817405</latitude>'
  f.puts '      <longitude>19.118485</longitude>'
  f.puts '      <range>5000000</range>'
  f.puts '      <tilt>0</tilt>'
  f.puts '      <heading>0</heading>'
  f.puts '    </LookAt>'
  
  Station.all.each do |station|
    f.puts "    <Placemark>"
    f.puts "      <name>#{station.name}</name>"
    f.puts "      <Point>"
    f.puts "        <coordinates>#{station.lng},#{station.lat}</coordinates>"
    f.puts "      </Point>"
    f.puts "    </Placemark>"
    puts "Creating placemarker for #{station.name}"
  end
  f.puts '  </Document>'
  f.puts '</kml>'
end
