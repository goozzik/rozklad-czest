# coding: utf-8
require 'machinist/active_record'

Station.blueprint(:station_from) do
  name { "ZANA" }
  lat  { 2 }
  lng  { 2 }
end

Station.blueprint(:station_to) do
  name { "MALOWNICZA" }
  lat  { 3 }
  lng  { 3 }
end

Station.blueprint(:station_kopernika) do
  name { "KOPERNIKA" }
  lat  { 4 }
  lng  { 4 }
end

Station.blueprint(:noline) do
  name { "NOLINE" }
  lat  { 5 }
  lng  { 5 }
end

Line.blueprint do
  stations { [Station.make!(:station_from), Station.make!(:station_to), Station.make!(:station_kopernika)] }
  number { "1" }
  direction { "MALOWNICZA" }
end

Schedule.blueprint do
  line { Line.make! }
  station { Station.find_by_name("ZANA") }
  arrival_at { Time.new(2011, 3, 24, 22, 40) }
  work { true }
  sunday { false }
  saturday { false }
  holiday { false }
end

Line.blueprint(:inversely) do
  stations { [Station.find_by_name('MALOWNICZA'), Station.find_by_name('ZANA')] }
  number { "1" }
  direction { "ZANA" }
end

Schedule.blueprint(:inversely) do
  line { Line.make!(:inversely) }
  station { Station.find_by_name('MALOWNICZA') }
  arrival_at { Time.new(2011, 3, 24, 22, 45) }
  work { true }
  sunday { false }
  saturday { false }
  holiday { false }
end

User.blueprint do
  user_name { "user" }
  password { "password" }
  password_confirmation { "password" }
end

Favourite.blueprint do
  name { "Dom" }
  Line.make!
  station_from { Line.first.stations.first.name }
  station_to { Line.first.stations.last.name }
  on_start_page { false }
  user { User.make! }
end
