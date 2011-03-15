class Station::Import < Station

  def self.get_id_by_name_if_exist(name)
    station = find_by_name(name)
    station.id if station
  end

end
