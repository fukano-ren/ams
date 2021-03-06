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

ActiveRecord::Schema.define(version: 20161219002328) do

  create_table "belongs", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "model"
    t.integer  "department_id"
    t.integer  "user_id"
    t.date     "acquired_on"
    t.date     "disponed_on"
    t.text     "memo"
    t.boolean  "delete_flg"
    t.datetime "updated_at",        null: false
    t.datetime "created_at",        null: false
    t.string   "set"
    t.datetime "soft_destroyed_at"
  end

  add_index "belongs", ["soft_destroyed_at"], name: "index_belongs_on_soft_destroyed_at"

  create_table "departments", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "password"
    t.integer  "department_id"
    t.boolean  "system"
    t.boolean  "admin"
    t.datetime "updated_at",    null: false
    t.datetime "created_at",    null: false
    t.string   "reset_digest"
  end

end
