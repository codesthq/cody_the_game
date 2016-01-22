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

ActiveRecord::Schema.define(version: 20160122123444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "level_id",   null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "level_id"
  end

  create_table "game_sessions", force: :cascade do |t|
    t.string   "cookie_key",             null: false
    t.integer  "points",     default: 0
    t.string   "name"
    t.integer  "max_level",  default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "position",    default: 0
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "conversation_id"
    t.integer  "character_id"
    t.string   "content"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "position",        default: 0
  end

  create_table "submissions", force: :cascade do |t|
    t.text     "content",                     null: false
    t.integer  "status",          default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "response"
    t.integer  "level_id",                    null: false
    t.string   "error_messages"
    t.integer  "game_session_id",             null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "level_id",   null: false
    t.text     "content",    null: false
    t.integer  "points",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "start_code"
  end

end
