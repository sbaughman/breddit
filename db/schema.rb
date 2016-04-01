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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160401160056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "summary"
    t.integer  "user_id"
    t.integer  "karma",      default: 0
  end

  add_index "links", ["user_id"], name: "index_links_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "bio"
    t.integer  "karma",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "value"
    t.integer  "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["link_id"], name: "index_votes_on_link_id", using: :btree

  add_foreign_key "links", "users"
  add_foreign_key "votes", "links"
end
