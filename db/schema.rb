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

ActiveRecord::Schema.define(:version => 20100312074242) do

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

end
