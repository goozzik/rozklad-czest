class AddGeoToStations < ActiveRecord::Migration

  def self.up
    add_column :stations, :lat, :float
    add_column :stations, :lng, :float
  end

  def self.down
    remove_column :stations, :lat
    remove_column :stations, :lng
  end

end
