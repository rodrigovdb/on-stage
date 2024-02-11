# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_11_003740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "band_users", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "mate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_band_users_on_band_id"
    t.index ["user_id"], name: "index_band_users_on_user_id"
  end

  create_table "bands", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setlist_songs", force: :cascade do |t|
    t.bigint "setlist_id", null: false
    t.bigint "song_id", null: false
    t.integer "display_sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setlist_id"], name: "index_setlist_songs_on_setlist_id"
    t.index ["song_id"], name: "index_setlist_songs_on_song_id"
  end

  create_table "setlists", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_setlists_on_band_id"
  end

  create_table "songs", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.string "name", null: false
    t.string "artist", null: false
    t.string "key"
    t.integer "duration"
    t.text "chords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_songs_on_band_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "band_users", "bands"
  add_foreign_key "band_users", "users"
  add_foreign_key "setlist_songs", "setlists"
  add_foreign_key "setlist_songs", "songs"
  add_foreign_key "setlists", "bands"
  add_foreign_key "songs", "bands"
end
