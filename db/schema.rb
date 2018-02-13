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

ActiveRecord::Schema.define(version: 20180213143017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "etags", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_etags_on_user_id"
  end

  create_table "first_party_cookies", force: :cascade do |t|
    t.string "token"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_first_party_cookies_on_user_id"
  end

  create_table "hsts", force: :cascade do |t|
    t.integer "user_id"
    t.string "token_ary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hsts_on_user_id"
  end

  create_table "local_storages", force: :cascade do |t|
    t.text "token"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_local_storages_on_user_id"
  end

  create_table "tracked_session_hsts_entries", force: :cascade do |t|
    t.integer "tracked_session_id"
    t.integer "url_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tracked_session_id"], name: "index_tracked_session_hsts_entries_on_tracked_session_id"
  end

  create_table "tracked_sessions", force: :cascade do |t|
    t.string "session_id"
    t.integer "first_party_cookie_id"
    t.integer "localstorage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "etag_id"
    t.index ["etag_id"], name: "index_tracked_sessions_on_etag_id"
    t.index ["first_party_cookie_id"], name: "index_tracked_sessions_on_first_party_cookie_id"
    t.index ["localstorage_id"], name: "index_tracked_sessions_on_localstorage_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "etags", "users"
end
