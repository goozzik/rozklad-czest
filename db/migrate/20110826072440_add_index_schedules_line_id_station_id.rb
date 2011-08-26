class AddIndexSchedulesLineIdStationId < ActiveRecord::Migration

  def self.up
    add_index :schedules, [:line_id, :station_id]
  end

  def self.down
    remove_index :schedules, [:line_id, :station_id]
  end

end
