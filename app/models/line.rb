class Line < ActiveRecord::Base
  has_many :schedules

  serialize :stations, Array

  def self.find_all_by_stations(stations)
    find(:all, :conditions => ["stations LIKE ?", "%#{stations.join("%")}%"])
    #lines = []
    #all.each do |line|
      #lines << line if line.stations.include?(stations)
    #end
    #lines
  end

  def self.find_first_by_stations(stations)
    find(:first, :conditions => ["stations LIKE ?", "%#{stations.join("%")}%"])
    #lines = []
    #all.each do |line|
      #lines << line if line.stations.include?(stations)
    #end
    #lines
  end

end
