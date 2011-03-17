class AddOnStartPageToFavourites < ActiveRecord::Migration
  def self.up
    add_column :favourites, :on_start_page, :boolean
  end

  def self.down
    remove_column :favourites, :on_start_page
  end
end
