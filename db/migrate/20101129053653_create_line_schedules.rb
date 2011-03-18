class CreateLineSchedules < ActiveRecord::Migration

  def self.up
    create_table :line_schedules do |t|
      t.timestamps
      t.integer :line_number, :null => false
      t.string :direction, :null => false
      t.string :stop_name, :null => false
      t.time :arrival_time, :null => false
      t.text :shedule_type, :null => false
      t.boolean :low_floor, :default => false            #wrzuca znacznik "D" dla kursu niskopodłogowego
      t.boolean :final_course, :default => false         #wrzuca znacznik "Z" dla kursu zjazdowego
      t.boolean :additional_stop, :default => false      #wrzuca znacznik danego dodatkowego przystanku o danej godzinie
    end
  end

  def self.down
    drop_table :line_schedules
  end

end
