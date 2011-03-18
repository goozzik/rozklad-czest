class CreateSchedules < ActiveRecord::Migration

  def self.up
    create_table :schedules do |t|
      t.integer :line_id
      t.integer :station_id
      t.time :arrival_at
      t.boolean :work, :default => false
      t.boolean :saturday, :default => false
      t.boolean :sunday, :default => false
      t.boolean :holiday, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end

end
