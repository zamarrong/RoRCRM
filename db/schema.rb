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

ActiveRecord::Schema.define(version: 20170718180140) do

  create_table "client_companies", force: true do |t|
    t.integer  "client_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "avatar"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "company"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.string   "telephone_2"
    t.string   "position"
    t.integer  "supplier_id"
  end

  create_table "costs", force: true do |t|
    t.integer  "product_id"
    t.decimal  "total",      precision: 10, scale: 0
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.integer  "client_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
  end

  create_table "notes", force: true do |t|
    t.datetime "date"
    t.text     "content"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
    t.integer  "user_id"
  end

  create_table "opportunities", force: true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.string   "currency"
    t.string   "valuation"
    t.string   "how_was_it_found"
    t.date     "opening_date"
    t.date     "due_date"
    t.float    "tax"
    t.decimal  "price",              precision: 10, scale: 0
    t.boolean  "closed"
    t.string   "title"
    t.text     "payment_conditions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
    t.string   "company"
    t.integer  "folio"
    t.text     "special_notes"
    t.date     "closed_date"
    t.integer  "company_id"
  end

  create_table "products", force: true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "brand"
    t.string   "model"
    t.string   "serial"
    t.decimal  "price",            precision: 16, scale: 6
    t.text     "notes"
    t.boolean  "is_not_here"
    t.boolean  "is_sold_and_here"
    t.boolean  "has_issues"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sold"
    t.string   "image"
    t.string   "year"
    t.boolean  "is_for_hf"
    t.string   "requirement_id"
    t.decimal  "investment",       precision: 16, scale: 6, default: 0.0
    t.text     "investment_notes"
    t.text     "price_notes"
    t.text     "profit_notes"
    t.string   "video"
  end

  create_table "purchase_items", force: true do |t|
    t.float    "quantity",                                   default: 0.0
    t.string   "part_number"
    t.string   "description"
    t.decimal  "price",             precision: 16, scale: 6, default: 0.0
    t.integer  "purchase_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_orders", force: true do |t|
    t.string   "company"
    t.string   "language"
    t.integer  "supplier_id"
    t.integer  "contact_id"
    t.integer  "shipping_address_id"
    t.string   "currency"
    t.date     "opening_date"
    t.decimal  "shipping_and_handling", precision: 16, scale: 6
    t.decimal  "other_charges",         precision: 16, scale: 6
    t.text     "special_notes"
    t.integer  "folio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipping_number"
    t.integer  "user_id"
    t.string   "shipping_company"
    t.integer  "company_id"
  end

  create_table "quotes", force: true do |t|
    t.text     "description"
    t.decimal  "quantity",       precision: 16, scale: 6
    t.decimal  "price",          precision: 16, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "opportunity_id"
    t.integer  "product_id"
    t.string   "image"
  end

  create_table "reminders", force: true do |t|
    t.text     "text"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "user_assigning_id"
  end

  create_table "requirements", force: true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.text     "description"
    t.date     "date"
    t.text     "budget"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "shipping_addresses", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "telephone_1"
    t.string   "telephone_2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_companies", force: true do |t|
    t.integer  "supplier_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.text     "terms"
    t.string   "avatar"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.string   "website"
    t.string   "name"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_companies", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "organization"
    t.string   "position"
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "fax_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.string   "website"
    t.text     "notes"
    t.boolean  "admin"
    t.string   "roles"
    t.integer  "current_company_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
