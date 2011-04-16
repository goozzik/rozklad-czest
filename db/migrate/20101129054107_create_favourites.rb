class CreateFavourites < ActiveRecord::Migration

  def self.up
    create_table :favourites do |t|
      t.string :station_from, :null => nil
      t.string :station_to, :null => nil
      t.string :line_number, :null => nil
      t.string :line_direction, :null => nil
      t.string :station_id, :null => nil
      t.string :name
      t.boolean :on_start_page
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stations
  end
end
