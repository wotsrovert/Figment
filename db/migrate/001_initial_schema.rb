class InitialSchema < ActiveRecord::Migration
    def self.up
        #
        #


        create_table "answers", :force => true do |t|
            t.integer  "question_id"
            t.integer  "project_id"
            t.text     "answer"
            t.datetime "created_at"
            t.datetime "updated_at"
        end

        add_index "answers", ["project_id"], :name => "index_answers_on_project_id"

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
            t.string   "str_location"
        end

        add_index "programs", ["project_id"], :name => "index_programs_on_project_id"

        create_table "project_categories", :force => true do |t|
            t.integer "project_id"
            t.integer "category_id"
        end

        create_table "project_requested_locations", :force => true do |t|
            t.integer "project_id"
            t.integer "location_id"
        end

        create_table "projects", :force => true do |t|
            t.text     "description"
            t.text     "notes"
            t.string   "duration"
            t.string   "title"
            t.string   "dimensions"
            t.boolean  "press"
            t.string   "placement_code"
            t.integer  "artist_id"
            t.string   "stipend"
            t.datetime "setup_at"
            t.datetime "created_at"
            t.datetime "updated_at"
            t.datetime "break_down_at"
            t.string   "status"
            t.integer  "curator_id"
            t.integer  "placed_location_id"
            t.string   "str_artist"
            t.string   "str_curator"
            t.string   "str_placed_location"
            t.boolean  "waiver_signed"
        end

        add_index "projects", ["status"], :name => "index_projects_on_status"

        create_table "questions", :force => true do |t|
            t.text     "category_ids"
            t.datetime "created_at"
            t.datetime "updated_at"
            t.string   "genre"
            t.string   "wording"
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
            t.string   "phone"
            t.string   "remember_me_code"
            t.datetime "anonymous_login_code_created_at"
            t.boolean  "is_placement",                                  :default => false
            t.string   "role"
        end

    end

    def self.down
        drop_table :answers
        drop_table :artists
        drop_table :categories
        drop_table :locations
        drop_table :programs
        drop_table :project_categories
        drop_table :project_requested_locations
        drop_table :projects
        drop_table :questions
        drop_table :users
    end
end
