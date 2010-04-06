class Line < ActiveRecord::Base

  serialize :stations, Array

  #def stations
    #self[:stations] ? Marshal.load(self[:stations]) : nil
  #end

  #def stations=(value)
    #self[:stations] = Marshal.dump(value)
  #end

  def self.find_all_by_stations(stations)
    find(:all, :conditions => ["stations LIKE ?", "%#{stations.join("%")}%"])
    #lines = []
    #all.each do |line|
      #lines << line if line.stations.include?(stations)
    #end
    #lines
  end

end
