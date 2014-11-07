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

ActiveRecord::Schema.define(version: 20141107061454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "queries", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "query",                    null: false
    t.integer  "ttl_minutes", default: 10, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "results", force: true do |t|
    t.uuid     "query_id",       null: false
    t.text     "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "execution_time"
    t.string   "error"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
