class CreateLinesStations < ActiveRecord::Migration

  def self.up
    create_table :lines_stations, :id => false do |t|
      t.integer :line_id
      t.integer :station_id
    end
  end

  def self.down
    drop_table :lines_stations
  end

end
