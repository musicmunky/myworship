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

ActiveRecord::Schema.define(version: 20151116221428) do

  create_table "announcement_types", force: :cascade do |t|
    t.string   "type_name",  limit: 255
    t.integer  "type_level", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "announcements", force: :cascade do |t|
    t.string   "heading",              limit: 255
    t.text     "message",              limit: 65535
    t.boolean  "is_active"
    t.integer  "user_id",              limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "announcement_type_id", limit: 4
  end

  create_table "attendances", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "attendances_users", id: false, force: :cascade do |t|
    t.integer "user_id",       limit: 4
    t.integer "attendance_id", limit: 4
  end

  add_index "attendances_users", ["attendance_id"], name: "index_attendances_users_on_attendance_id", using: :btree
  add_index "attendances_users", ["user_id"], name: "index_attendances_users_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50,    default: ""
    t.text     "comment",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.string   "role",             limit: 255,   default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "notification_type",   limit: 255
    t.boolean  "is_active"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "notification_method", limit: 255, default: "EMAIL"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.date     "schedule_date"
    t.text     "notes",         limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "song_order",    limit: 65535
  end

  create_table "schedules_songs", id: false, force: :cascade do |t|
    t.integer "song_id",     limit: 4
    t.integer "schedule_id", limit: 4
  end

  add_index "schedules_songs", ["schedule_id"], name: "index_songs_schedules_on_schedule_id", using: :btree
  add_index "schedules_songs", ["song_id"], name: "index_songs_schedules_on_song_id", using: :btree

  create_table "song_keys", force: :cascade do |t|
    t.string   "key_symbol",    limit: 255
    t.string   "key_full_name", limit: 255
    t.string   "key_root",      limit: 255
    t.string   "key_modifier",  limit: 255
    t.integer  "capo_fret",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "song_keys_songs", id: false, force: :cascade do |t|
    t.integer "song_id",     limit: 4
    t.integer "song_key_id", limit: 4
  end

  add_index "song_keys_songs", ["song_id"], name: "index_song_song_keys_on_song_id", using: :btree
  add_index "song_keys_songs", ["song_key_id"], name: "index_song_song_keys_on_song_key_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "author",     limit: 255
    t.integer  "capo_fret",  limit: 4
    t.string   "media_link", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "lyrics",     limit: 65535
    t.string   "composer",   limit: 255
  end

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
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "archive",                            default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
