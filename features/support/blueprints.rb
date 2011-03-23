require 'machinist/active_record'

Station.blueprint(:station_from) do
  name { "ZANA" }
  lat  { 1 }
  lng  { 1 }
end

Station.blueprint(:station_to) do
  name { "MALOWNICZA" }
  lat  { 2 }
  lng  { 2 }
end

Line.blueprint do
  stations { [1, 2] }
end

Favourite.blueprint do
  name { "Dom" }
  station_from { "ZANA" }
  station_to { "MALOWNICZA" }
  on_start_page { false }
end
