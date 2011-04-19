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
  object.stations << Station.make!(:station_from)
  object.stations << Station.make!(:station_to)
  object.stations << Station.make!(:station_kopernika)
  number { "1" }
  direction { "NIERADA" }
end

Schedule.blueprint do
  line { Line.make! }
  station { Station.find(object.line.stations.first) }
  arrival_at { Time.new(2011, 3, 24, 22, 40) }
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
