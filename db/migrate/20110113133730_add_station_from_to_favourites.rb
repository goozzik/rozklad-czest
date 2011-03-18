class AddStationFromToFavourites < ActiveRecord::Migration

  def self.up
    add_column :favourites, :station_from, :string
  end

  def self.down
    remove_column :favourites, :station_from
  end

end
