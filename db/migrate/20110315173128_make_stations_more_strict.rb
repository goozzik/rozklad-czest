class MakeStationsMoreStrict < ActiveRecord::Migration

  def self.up
    change_column :stations, :name, :string, :null => false
    change_column :stations, :lat, :float, :null => false
    change_column :stations, :lng, :float, :null => false
    add_index :stations, :name, :unique => true
    add_index :stations, [:lat, :lng], :unique => true
  end

  def self.down
    remove_index :stations, [:lat, :lng]
    remove_index :stations, :name
    change_column :stations, :name, :string
    change_column :stations, :lat, :float
    change_column :stations, :lng, :float
  end

end
