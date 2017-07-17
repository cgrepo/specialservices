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

ActiveRecord::Schema.define(version: 20170717174918) do

  create_table "expeditures", force: :cascade do |t|
    t.float    "feeding"
    t.float    "rent"
    t.float    "electricity"
    t.float    "water"
    t.float    "fuel"
    t.float    "education"
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "expeditures", ["person_id"], name: "index_expeditures_on_person_id"

  create_table "living_places", force: :cascade do |t|
    t.string   "kind"
    t.string   "wall_mat"
    t.string   "roof_mat"
    t.string   "floor_mat"
    t.integer  "rooms"
    t.string   "bedroom"
    t.string   "kitchen"
    t.string   "dinningroom"
    t.string   "bathroom"
    t.text     "notes"
    t.string   "lighting_service"
    t.string   "water_service"
    t.integer  "person_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "living_places", ["person_id"], name: "index_living_places_on_person_id"

  create_table "other_expeditures", force: :cascade do |t|
    t.string   "name"
    t.float    "amount"
    t.integer  "expediture_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "other_expeditures", ["expediture_id"], name: "index_other_expeditures_on_expediture_id"

  create_table "other_services", force: :cascade do |t|
    t.string   "name"
    t.integer  "LivingPlace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "other_services", ["LivingPlace_id"], name: "index_other_services_on_LivingPlace_id"

  create_table "people", force: :cascade do |t|
    t.string   "kind"
    t.string   "name"
    t.integer  "age"
    t.string   "gender"
    t.string   "civil_status"
    t.string   "occupation"
    t.float    "salary"
    t.string   "scolarship"
    t.string   "address"
    t.string   "workplace"
    t.string   "current_residence"
    t.string   "relationship"
    t.string   "phone"
    t.date     "admission_date"
    t.date     "birth_date"
    t.string   "transportation"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
