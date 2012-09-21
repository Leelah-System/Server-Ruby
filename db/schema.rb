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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120921093929) do

  create_table "addresses", :force => true do |t|
    t.string   "name"
    t.string   "street_number"
    t.string   "street"
    t.string   "additional_address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "country"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "addresses", ["addressable_id"], :name => "index_addresses_on_addressable_id"

  create_table "categories", :force => true do |t|
    t.string   "label"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "color",       :default => "FFFFFF"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "subname"
    t.text     "activity"
    t.string   "legal_form"
    t.text     "registration_number"
    t.integer  "head_office_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "companies", ["head_office_id"], :name => "index_companies_on_head_office_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "fax"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "contacts", ["contactable_id"], :name => "index_contacts_on_contactable_id"

  create_table "order_lines", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.float    "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "order_lines", ["order_id"], :name => "index_order_lines_on_order_id"
  add_index "order_lines", ["product_id"], :name => "index_order_lines_on_product_id"

  create_table "orders", :force => true do |t|
    t.string   "reference"
    t.float    "amount"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "pictures", :force => true do |t|
    t.string   "path"
    t.string   "label"
    t.string   "name"
    t.text     "description"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "reference",   :null => false
    t.string   "label"
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.float    "stock"
    t.integer  "logo_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.string   "salt"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
