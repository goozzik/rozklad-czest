class CreateStations < ActiveRecord::Migration

  def self.up
    create_table :stations do |t|
      t.string :name, :null => false 
      t.float :lat, :null => false
      t.float :lng, :null => false
      add_index :stations, :name, :unique => true
      add_index :stations, [:lat, :lng], :unique => true

      t.timestamps
    end
  end

  def self.down
    drop_table :stations
  end

end
