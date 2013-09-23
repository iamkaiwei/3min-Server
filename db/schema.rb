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

ActiveRecord::Schema.define(version: 20130923135653) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "images", force: true do |t|
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
    t.string   "name"
    t.text     "description"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["attachable_id", "attachable_type"], name: "index_images_on_attachable_id_and_attachable_type", using: :btree

  create_table "products", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "category_id"
    t.text     "description"
    t.decimal  "price"
    t.boolean  "sold_out",    default: false
    t.hstore   "comments",                    array: true
    t.integer  "likes"
    t.integer  "dislikes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["dislikes"], name: "index_products_on_dislikes", using: :btree
  add_index "products", ["likes"], name: "index_products_on_likes", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", using: :btree
  add_index "products", ["price"], name: "index_products_on_price", using: :btree
  add_index "products", ["sold_out"], name: "index_products_on_sold_out", using: :btree
  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "product_id"
    t.string   "meetup_place"
    t.hstore   "chat",         array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["buyer_id"], name: "index_transactions_on_buyer_id", using: :btree
  add_index "transactions", ["product_id"], name: "index_transactions_on_product_id", using: :btree
  add_index "transactions", ["seller_id"], name: "index_transactions_on_seller_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                default: "", null: false
    t.integer  "sign_in_count",        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "birthday"
    t.string   "udid"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["birthday"], name: "index_users_on_birthday", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", using: :btree
  add_index "users", ["full_name"], name: "index_users_on_full_name", using: :btree
  add_index "users", ["gender"], name: "index_users_on_gender", using: :btree
  add_index "users", ["udid"], name: "index_users_on_udid", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
