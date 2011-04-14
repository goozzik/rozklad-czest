class CreateStations < ActiveRecord::Migration

  def self.up
    create_table :stations do |t|
      t.string :name, :null => false 
      t.float :lat, :null => false
      t.float :lng, :null => false
    end
    add_index :stations, :name, :unique => true
    add_index :stations, [:lat, :lng], :unique => true
  end

  def self.down
    drop_table :stations
  end

end
