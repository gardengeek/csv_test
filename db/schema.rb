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

ActiveRecord::Schema.define(:version => 20110701143627) do

  create_table "countries", :force => true do |t|
    t.string   "code",       :limit => 2
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "state_id"
    t.date     "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "states", :force => true do |t|
    t.string   "country_code", :limit => 2
    t.string   "code",         :limit => 2
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                 :null => false
    t.string   "encrypted_password",   :limit => 128
    t.string   "salt",                 :limit => 128
    t.string   "confirmation_token",   :limit => 128
    t.string   "remember_token",       :limit => 128
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",                              :default => true
    t.datetime "confirmed_at"
    t.string   "time_zone"
    t.string   "phone_number"
    t.string   "company_name"
    t.string   "title"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "postal_code"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
