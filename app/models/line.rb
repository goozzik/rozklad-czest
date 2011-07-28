class Line < ActiveRecord::Base

  has_many :schedules
  has_and_belongs_to_many :stations
  before_validation :get_map_url

  LINES_ROAD_MAP_LINKS = [
    "http://maps.google.com/maps/ms?msa=0&msid=214247094233741962570.0004a8f32cfdbad18e1f9&ie=UTF8&ll=50.812123,19.144642&spn=0.056322,0.057549&output=embed",
    "http://maps.google.com/maps/ms?msa=0&ie=UTF8&ll=50.81407,19.144707&spn=0.056322,0.057549&msid=214247094233741962570.0004a8f32facabc0d41c2&output=embed",
    "http://maps.google.pl/maps/ms?msa=0&msid=214247094233741962570.0004a8f331fb8bffdd953&hl=pl&ie=UTF8&ll=50.827734,19.121876&spn=0.056322,0.03504&output=embed",
    "http://maps.google.pl/maps/ms?msa=0&hl=pl&ie=UTF8&msid=214247094233741962570.0004a8f333b39d6d11210&ll=50.812123,19.133388&spn=0.056322,0.03504&output=embed",
    "http://maps.google.com/maps/ms?ie=UTF&msa=0&msid= 214247094233741962570.0004a8f333b39d6d11210
    "]


  def self.find_all_by_stations(stations)
    if _lines = joins(:stations).all(:conditions => ["stations.id = ?", stations[0]])
      lines = []
      _lines.each do |line| 
        if line.stations.include?(Station.find(stations[1]))
          station_from = Station.find(stations[0])
          station_to = Station.find(stations[1])
          station_from_index = line.stations.index(station_from)
          station_to_index = line.stations.index(station_to)
          lines << line if station_from_index < station_to_index
        end
      end
    end
    return lines == 0 ? nil : lines
  end

  def self.ids_by_stations(*stations)
    if _lines = joins(:stations).all(:conditions => ["stations.id = ?", stations[0]])
      lines = []
      _lines.each do |line| 
        if line.stations.include?(Station.find(stations[1]))
          station_from = Station.find(stations[0])
          station_to = Station.find(stations[1])
          station_from_index = line.stations.index(station_from)
          station_to_index = line.stations.index(station_to)
          lines << line.id if station_from_index < station_to_index
        end
      end
    end
    return lines == 0 ? nil : lines
  end

  def self.find_first_by_stations(stations)
    if _lines = joins(:stations).all(:conditions => ["stations.id = ?", stations[0]])
      _lines.each do |line| 
        if line.stations.include?(Station.find(stations[1]))
          station_from = Station.find(stations[0])
          station_to = Station.find(stations[1])
          station_from_index = line.stations.index(station_from)
          station_to_index = line.stations.index(station_to)
          return line if station_from_index < station_to_index
        end
      end
    end
    return nil
  end
  
  def self.get_numbers
    lines = []
    Line.all.each do |line|
      lines << line.number unless lines.include?(line.number)
    end
    return lines
  end

  private

    def get_map_url
      if Line.count == 0
        self.map_url = LINES_ROAD_MAP_LINKS[0] 
      else
        self.map_url = LINES_ROAD_MAP_LINKS[Line.last.id]
      end
    end

end
