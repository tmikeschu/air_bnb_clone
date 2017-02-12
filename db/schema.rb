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


ActiveRecord::Schema.define(version: 20170210195755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "couch_photos", force: :cascade do |t|
    t.string   "title"
    t.string   "caption"
    t.string   "image"
    t.integer  "couch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["couch_id"], name: "index_couch_photos_on_couch_id", using: :btree
  end

  create_table "couches", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "street_address"
    t.text     "city"
    t.text     "state"
    t.text     "zipcode"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_couches_on_user_id", using: :btree
  end

  create_table "nights", force: :cascade do |t|
    t.date     "date"
    t.integer  "couch_id"
    t.integer  "reservation_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["couch_id"], name: "index_nights_on_couch_id", using: :btree
    t.index ["reservation_id"], name: "index_nights_on_reservation_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "phone_number"
  end

  add_foreign_key "couch_photos", "couches"
  add_foreign_key "couches", "users"
  add_foreign_key "nights", "couches"
  add_foreign_key "reservations", "users"
end
