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

Line.blueprint do
  number { "1" }
  direction { "NIERADA" }
  stations { [Station.make!(:station_from).id, Station.make!(:station_to).id] }
end

Schedule.blueprint do
  line { Line.make! }
  station { Station.find(object.line.stations.first) } 
  arrival_at { Time.new(2011, 3, 24, 22, 40) }
  work { true }
end

Favourite.blueprint do
  name { "Dom" }
  line = Line.make!
  station_from { Station.find(line.stations.first).name }
  station_to { Station.find(line.stations.last).name }
  on_start_page { false }
end
