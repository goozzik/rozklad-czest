class CreateFavourites < ActiveRecord::Migration

  def self.up
    create_table :favourites do |t|
      t.string :station_from, :null => false
      t.string :station_to, :null => false
      t.string :line_number, :null => false
      t.string :line_direction, :null => false
      t.string :station_id, :null => false
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
