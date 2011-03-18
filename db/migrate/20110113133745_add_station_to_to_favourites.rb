class AddStationToToFavourites < ActiveRecord::Migration

  def self.up
    add_column :favourites, :station_to, :string
  end

  def self.down
    remove_column :favourites, :station_to
  end

end
