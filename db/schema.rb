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

ActiveRecord::Schema.define(:version => 20120317000949) do

  create_table "categories", :force => true do |t|
    t.string   "label"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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
