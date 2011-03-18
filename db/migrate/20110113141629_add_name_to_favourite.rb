class AddNameToFavourite < ActiveRecord::Migration

  def self.up
    add_column :favourites, :name, :string
  end

  def self.down
    remove_column :favourites, :name
  end

end
