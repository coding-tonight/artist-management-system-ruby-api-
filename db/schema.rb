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

ActiveRecord::Schema[7.2].define(version: 2024_10_23_090437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "musics", force: :cascade do |t|
    t.string "title", null: false
    t.string "album_name", null: false
    t.integer "genre", null: false
    t.bigint "singer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["singer_id"], name: "index_musics_on_singer_id"
  end

  create_table "singers", force: :cascade do |t|
    t.string "name", null: false
    t.date "dob"
    t.integer "gender"
    t.string "address"
    t.date "first_release_year"
    t.integer "no_of_albums_released"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["name"], name: "index_singers_on_name", unique: true
    t.index ["user_id"], name: "index_singers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.string "phone"
    t.integer "gender"
    t.integer "role"
    t.date "dob"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "singers", "users"
end
