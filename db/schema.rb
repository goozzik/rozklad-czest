# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110413044254) do

  create_table "favourites", :force => true do |t|
    t.string   "station_from",   :null => false
    t.string   "station_to",     :null => false
    t.string   "line_number",    :null => false
    t.string   "line_direction", :null => false
    t.string   "station_id",     :null => false
    t.string   "name"
    t.boolean  "on_start_page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_schedules", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_number",                        :null => false
    t.string   "direction",                          :null => false
    t.string   "stop_name",                          :null => false
    t.time     "arrival_time",                       :null => false
    t.text     "shedule_type",                       :null => false
    t.boolean  "low_floor",       :default => false
    t.boolean  "final_course",    :default => false
    t.boolean  "additional_stop", :default => false
  end

  create_table "lines", :force => true do |t|
    t.string "number"
    t.string "direction"
  end

  create_table "lines_stations", :id => false, :force => true do |t|
    t.integer "line_id"
    t.integer "station_id"
  end

  create_table "schedules", :force => true do |t|
    t.integer "line_id"
    t.integer "station_id"
    t.time    "arrival_at"
    t.boolean "work",       :default => false
    t.boolean "saturday",   :default => false
    t.boolean "sunday",     :default => false
    t.boolean "holiday",    :default => false
  end

  create_table "stations", :force => true do |t|
    t.string "name", :null => false
    t.float  "lat",  :null => false
    t.float  "lng",  :null => false
  end

  add_index "stations", ["lat", "lng"], :name => "index_stations_on_lat_and_lng", :unique => true
  add_index "stations", ["name"], :name => "index_stations_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
