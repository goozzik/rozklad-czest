class Line < ActiveRecord::Base

  has_many :schedules
  has_and_belongs_to_many :stations

  def self.find_all_by_stations(stations)
    if _lines = joins(:stations).all(:conditions => ["stations.id = ?", stations[0]])
      lines = []
      _lines.each { |line| lines << line if line.stations.include?(Station.find(stations[1])) }
    end
    return lines == 0 ? nil : lines
  end

  def self.ids_by_stations(*stations)
    if _lines = joins(:stations).all(:conditions => ["stations.id = ?", stations[0]])
      lines = []
      _lines.each { |line| lines << line.id if line.stations.include?(Station.find(stations[1])) }
    end
    return lines == 0 ? nil : lines
  end

  def self.find_first_by_stations(stations)
    if _lines = joins(:stations).all(:conditions => ["stations.id = ?", stations[0]])
      _lines.each { |line| return line if line.stations.include?(Station.find(stations[1])) }
    end
    return nil
  end

end
