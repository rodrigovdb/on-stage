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

ActiveRecord::Schema.define(version: 20151212133531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "band_users", force: :cascade do |t|
    t.integer  "band_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "band_users", ["band_id"], name: "index_band_users_on_band_id", using: :btree
  add_index "band_users", ["user_id"], name: "index_band_users_on_user_id", using: :btree

  create_table "bands", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bands", ["user_id"], name: "index_bands_on_user_id", using: :btree

  create_table "setlist_songs", force: :cascade do |t|
    t.integer  "setlist_id"
    t.integer  "song_id"
    t.integer  "display_sort"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "setlist_songs", ["setlist_id"], name: "index_setlist_songs_on_setlist_id", using: :btree
  add_index "setlist_songs", ["song_id"], name: "index_setlist_songs_on_song_id", using: :btree

  create_table "setlists", force: :cascade do |t|
    t.integer  "band_id"
    t.string   "name"
    t.date     "date"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "setlists", ["band_id"], name: "index_setlists_on_band_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.integer  "band_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "artist"
    t.string   "key"
    t.integer  "duration"
    t.text     "chords"
  end

  add_index "songs", ["band_id"], name: "index_songs_on_band_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "band_users", "bands"
  add_foreign_key "band_users", "users"
  add_foreign_key "bands", "users"
  add_foreign_key "setlist_songs", "setlists"
  add_foreign_key "setlist_songs", "songs"
  add_foreign_key "setlists", "bands"
  add_foreign_key "songs", "bands"
end
