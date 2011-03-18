class Line < ActiveRecord::Base

  has_many :schedules
  serialize :stations, Array

  def self.find_all_by_stations(stations)
    find(:all, :conditions => ["stations LIKE ?", "%#{stations.join("%")}%"])
  end

  def self.ids_by_stations(*stations)
    return [] if stations.empty?
    find(:all, :conditions => ["stations LIKE ?", "%#{stations.join("%")}%"], :select => 'id').collect(&:id)
  end

  def self.find_first_by_stations(stations)
    find(:first, :conditions => ["stations LIKE ?", "%#{stations.join("%")}%"])
  end

end
