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

ActiveRecord::Schema.define(:version => 0) do

  create_table "artists", :force => true do |t|
    t.string   "public_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "website"
    t.string   "group_email"
    t.text     "biography"
    t.string   "organization"
    t.text     "names_list"
    t.text     "notes"
    t.string   "contact_phone"
    t.boolean  "is_organization"
  end

  create_table "categories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "locations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.string   "zone_code"
  end

  create_table "programs", :force => true do |t|
    t.integer  "project_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "location_id"
  end

  add_index "programs", ["project_id"], :name => "index_programs_on_project_id"

  create_table "projects", :force => true do |t|
    t.text     "description",            :limit => 255
    t.string   "dimensions"
    t.string   "duration"
    t.boolean  "press"
    t.string   "stipend"
    t.text     "notes"
    t.string   "placement_code"
    t.integer  "artist_id"
    t.string   "title"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "setup_at"
    t.datetime "updated_at"
    t.datetime "break_down_at"
    t.integer  "curator_id"
    t.integer  "placed_location_id"
    t.string   "category_ids"
    t.string   "requested_location_ids"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password",                :limit => 40
    t.string   "salt",                            :limit => 40
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_logged_in_at"
    t.string   "anonymous_login_code"
    t.boolean  "is_root",                                       :default => false
    t.boolean  "is_artist",                                     :default => false
    t.boolean  "is_curator",                                    :default => false
    t.boolean  "is_director",                                   :default => false
    t.boolean  "is_admin",                                      :default => false
    t.boolean  "is_spectator",                                  :default => true
    t.string   "phone"
    t.string   "remember_me_code"
    t.datetime "anonymous_login_code_created_at"
  end

end
