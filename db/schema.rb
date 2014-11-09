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

ActiveRecord::Schema.define(version: 20141109063042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "office_id"
    t.integer  "document_id"
    t.text     "body"
    t.integer  "user_role",   default: 0
    t.boolean  "erased",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_routes", force: true do |t|
    t.integer  "document_id"
    t.integer  "office_id"
    t.datetime "date_in"
    t.datetime "date_out"
    t.integer  "status",        default: 0
    t.integer  "next_route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_types", force: true do |t|
    t.string   "name"
    t.string   "route"
    t.integer  "owner_id"
    t.boolean  "erased",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "name"
    t.integer  "document_type_id"
    t.integer  "office_id"
    t.string   "owner"
    t.string   "tracking_number"
    t.integer  "status",           default: 0
    t.boolean  "erased",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "office_id"
    t.text     "body"
    t.string   "link",       default: "#"
    t.integer  "role"
    t.boolean  "seen",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "office_staffs", force: true do |t|
    t.string   "name"
    t.integer  "office_id"
    t.boolean  "erased",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.boolean  "erased",                 default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offices", ["email"], name: "index_offices_on_email", unique: true, using: :btree
  add_index "offices", ["reset_password_token"], name: "index_offices_on_reset_password_token", unique: true, using: :btree

end
