class Station < ActiveRecord::Base
  has_many :schedules
  acts_as_mappable

  def self.get_id_by_name_if_exist(name)
    station = find_by_name(name)
    station.id if station
  end

end
