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

ActiveRecord::Schema.define(version: 20151012112355) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "asset_locations", force: :cascade do |t|
    t.string  "name",     limit: 100, null: false
    t.integer "owner_id", limit: 4,   null: false
  end

  add_index "asset_locations", ["owner_id"], name: "assets_assetlocation_cb902d83", using: :btree

  create_table "assets", force: :cascade do |t|
    t.string  "serial",            limit: 100,        null: false
    t.string  "brand",             limit: 100,        null: false
    t.string  "kind",              limit: 100,        null: false
    t.date    "date_acquired",                        null: false
    t.integer "user_id",           limit: 4
    t.text    "comment",           limit: 65535, null: false
    t.string  "ware",              limit: 50,         null: false
    t.integer "asset_location_id", limit: 4,          null: false
    t.boolean "recycled",                             null: false
    t.integer "owner_id",          limit: 4,          null: false
  end

  add_index "assets", ["asset_location_id"], name: "assets_afbb987d", using: :btree
  add_index "assets", ["owner_id"], name: "assets_cb902d83", using: :btree

  create_table "businesses", force: :cascade do |t|
    t.string  "name",     limit: 100, null: false
    t.integer "owner_id", limit: 4,   null: false
  end

  add_index "businesses", ["owner_id"], name: "assets_business_cb902d83", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "owner_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "typeof",     limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.integer  "owner_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "level",      limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.integer  "owner_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ticket_categories", force: :cascade do |t|
    t.string  "name",     limit: 100, null: false
    t.integer "owner_id", limit: 4,   null: false
  end

  add_index "ticket_categories", ["owner_id"], name: "assets_ticketcategory_cb902d83", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer  "ticket_category_id", limit: 4,   null: false
    t.string   "issue",              limit: 100, null: false
    t.integer  "user_id",            limit: 4
    t.datetime "date_opened",                    null: false
    t.datetime "date_closed"
    t.string   "explanation",        limit: 400
    t.string   "status",             limit: 100, null: false
    t.string   "severity",           limit: 100, null: false
    t.string   "remedy",             limit: 400
    t.integer  "owner_id",           limit: 4,   null: false
  end

  add_index "tickets", ["owner_id"], name: "assets_ticket_cb902d83", using: :btree
  add_index "tickets", ["ticket_category_id"], name: "assets_ticket_6f33f001", using: :btree
  add_index "tickets", ["user_id"], name: "assets_ticket_6340c63c", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "firstname",              limit: 100
    t.string   "lastname",               limit: 100
    t.string   "username",               limit: 18
    t.integer  "business_id",            limit: 4
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.boolean  "leaver",                             default: false, null: false
    t.string   "time_zone",              limit: 255, default: "UTC", null: false
    t.integer  "group_id",               limit: 4
    t.string   "department",             limit: 255
    t.string   "position",               limit: 255
    t.string   "landline_phone",         limit: 255
    t.string   "mobile_phone",           limit: 255
    t.integer  "profile_id",             limit: 4
  end

  add_index "users", ["business_id"], name: "fk_rails_0ed4ddb088", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["group_id"], name: "fk_rails_cdd25752fc", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "users", "businesses"
  add_foreign_key "users", "groups"
end
