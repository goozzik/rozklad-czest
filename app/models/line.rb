class Line < ActiveRecord::Base

  has_many :schedules
  has_and_belongs_to_many :stations
  before_validation :get_map_url

  LINES_ROAD_MAP_LINKS = [
    "http://maps.google.com/maps/ms?msa=0&msid=214247094233741962570.0004a8f32cfdbad18e1f9&ie=UTF8&ll=50.812123,19.144642&spn=0.056322,0.057549&output=embed",
    "http://maps.google.com/maps/ms?msa=0&ie=UTF8&ll=50.81407,19.144707&spn=0.056322,0.057549&msid=214247094233741962570.0004a8f32facabc0d41c2&output=embed",
    "http://maps.google.pl/maps/ms?msa=0&msid=214247094233741962570.0004a8f331fb8bffdd953&hl=pl&ie=UTF8&ll=50.827734,19.121876&spn=0.056322,0.03504&output=embed",
    "http://maps.google.pl/maps/ms?msa=0&hl=pl&ie=UTF8&msid=214247094233741962570.0004a8f333b39d6d11210&ll=50.812123,19.133388&spn=0.056322,0.03504&output=embed",
    "http://maps.google.com/maps/ms?ie=UTF&msa=0&msid= 214247094233741962570.0004a8f333b39d6d11210"
  ]


  def self.find_first_by_stations(station_from_id, station_to_id)
    connecting_stations_with_direction(station_from_id, station_to_id).first
  end

  def self.find_all_by_stations(station_from_id, station_to_id)
    connecting_stations_with_direction(station_from_id, station_to_id)
  end

  def self.ids_by_stations(station_from_id, station_to_id)
    connecting_stations_with_direction(station_from_id, station_to_id).collect(&:id)
  end

  def self.connecting_stations_with_direction(station_from_id, station_to_id)
    connecting_stations(station_from_id, station_to_id).select do |line|
      line.station_index(station_from_id) < line.station_index(station_to_id)
    end
  end

  def self.connecting_stations(station_from_id, station_to_id)
    station_object = Station.find(station_to_id)
    with_station(station_from_id).select do |line|
      line.stations.include?(station_object)
    end
  end

  def self.with_station(station_id)
    joins(:stations).all(:conditions => ["stations.id = ?", station])
  end

  def station_index(station_id)
    station_object = Station.find(station_id)
    stations.index(station_object)
  end

  def self.get_numbers
    all.collect(&:number).uniq
  end

  private

    def get_map_url
      self.map_url = LINES_ROAD_MAP_LINKS[(Line.try(:last).try(:id) or 0)]
    end

end
