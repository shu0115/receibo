# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20111211034917) do

  create_table "items", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "buy_date"
  end

  create_table "users", :force => true do |t|
    t.string   "twitter_id"
    t.string   "login"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "location"
    t.string   "description"
    t.string   "profile_image_url"
    t.string   "url"
    t.boolean  "protected"
    t.string   "profile_background_color"
    t.string   "profile_sidebar_fill_color"
    t.string   "profile_link_color"
    t.string   "profile_sidebar_border_color"
    t.string   "profile_text_color"
    t.string   "profile_background_image_url"
    t.boolean  "profile_background_tile"
    t.integer  "friends_count"
    t.integer  "statuses_count"
    t.integer  "followers_count"
    t.integer  "favourites_count"
    t.integer  "utc_offset"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
