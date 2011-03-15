class Station::Import < Station

  def self.get_id_by_name_if_exist(name)
    station = find_by_name(name)
    station.id if station
  end

  def self.create_if_needed!(attributes)
    create!(attributes) unless find(:first, :conditions => attributes)
  end

end
