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

ActiveRecord::Schema.define(version: 20160112142856) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_infos", force: :cascade do |t|
    t.text     "description"
    t.boolean  "favorites_are_showable",        default: true, null: false
    t.boolean  "utauloids_are_showable",        default: true, null: false
    t.boolean  "notif_when_vb_updated",         default: true, null: false
    t.boolean  "notif_when_utauloid_faved",     default: true, null: false
    t.boolean  "notif_when_utauloid_commented", default: true, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "user_links", force: :cascade do |t|
    t.text     "link"
    t.integer  "user_info_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname",                            null: false
    t.string   "email",                               null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role",                   default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "utaloid_characteristics", force: :cascade do |t|
    t.integer  "utauloid_id",             null: false
    t.integer  "voice_characteristic_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "utaloid_languages", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "utauloid_types", force: :cascade do |t|
    t.integer  "utauloid_id",       null: false
    t.integer  "voicebank_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "utauloids", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "japanese_name"
    t.integer  "gender",          null: false
    t.datetime "vb_release_date"
    t.datetime "vb_last_update"
    t.boolean  "show_appends",    null: false
    t.integer  "category_id"
    t.string   "creator"
    t.boolean  "creator_is_user"
    t.integer  "creator_id"
    t.integer  "difficulty"
    t.text     "wiki_url"
    t.text     "vocadb_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  create_table "voice_banks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                         null: false
    t.text     "download_link",                null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_append",     default: true, null: false
  end

  add_index "voice_banks", ["user_id"], name: "index_voice_banks_on_user_id"

  create_table "voice_characteristics", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voice_languages", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voicebank_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
