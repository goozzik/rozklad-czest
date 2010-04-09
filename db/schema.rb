# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100406123344) do

  create_table "line_schedules", :force => true do |t|
    t.datetime "time",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_number",                        :null => false
    t.string   "direction",                          :null => false
    t.string   "stop_name",                          :null => false
    t.time     "arrival_time",                       :null => false
    t.text     "shedule_type",                       :null => false
    t.boolean  "low_floor",       :default => false, :null => false
    t.boolean  "final_course",    :default => false, :null => false
    t.boolean  "additional_stop", :default => false, :null => false
  end

  create_table "lines", :force => true do |t|
    t.string   "number"
    t.string   "direction"
    t.text     "stations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "line_id"
    t.integer  "station_id"
    t.time     "arrival_at"
    t.boolean  "work",       :default => false
    t.boolean  "saturday",   :default => false
    t.boolean  "sunday",     :default => false
    t.boolean  "holiday",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
