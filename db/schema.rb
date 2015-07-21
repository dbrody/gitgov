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

ActiveRecord::Schema.define(version: 20150721054128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_fluffs", force: true do |t|
    t.integer  "user_id",             limit: 8
    t.integer  "document_element_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "action_fluffs", ["document_element_id"], name: "index_action_fluffs_on_document_element_id", using: :btree
  add_index "action_fluffs", ["user_id", "document_element_id"], name: "index_action_fluffs_on_user_id_and_document_element_id", unique: true, using: :btree
  add_index "action_fluffs", ["user_id"], name: "index_action_fluffs_on_user_id", using: :btree

  create_table "action_importances", force: true do |t|
    t.integer  "user_id",             limit: 8
    t.integer  "document_element_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "action_importances", ["document_element_id"], name: "index_action_importances_on_document_element_id", using: :btree
  add_index "action_importances", ["user_id", "document_element_id"], name: "index_action_importances_on_user_id_and_document_element_id", unique: true, using: :btree
  add_index "action_importances", ["user_id"], name: "index_action_importances_on_user_id", using: :btree

  create_table "action_suspicions", force: true do |t|
    t.integer  "user_id",             limit: 8
    t.integer  "document_element_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "action_suspicions", ["document_element_id"], name: "index_action_suspicions_on_document_element_id", using: :btree
  add_index "action_suspicions", ["user_id", "document_element_id"], name: "index_action_suspicions_on_user_id_and_document_element_id", unique: true, using: :btree
  add_index "action_suspicions", ["user_id"], name: "index_action_suspicions_on_user_id", using: :btree

  create_table "document_elements", force: true do |t|
    t.integer  "document_id", limit: 8
    t.string   "type"
    t.integer  "parent_id",   limit: 8
    t.integer  "position"
    t.string   "numeral"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft",         limit: 8, null: false
    t.integer  "rgt",         limit: 8, null: false
  end

  add_index "document_elements", ["document_id"], name: "index_document_elements_on_document_id", using: :btree
  add_index "document_elements", ["parent_id"], name: "index_document_elements_on_parent_id", using: :btree

  create_table "documents", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moments", force: true do |t|
    t.string   "type"
    t.integer  "content_type"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moments", ["user_id"], name: "index_moments_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider",                            null: false
    t.string   "uid",                    default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_of_birth"
    t.string   "where_born"
    t.integer  "finalized_registration"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
