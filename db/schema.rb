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

ActiveRecord::Schema.define(:version => 20130327030218) do

  create_table "approvals", :force => true do |t|
    t.integer  "expense_id"
    t.string   "level"
    t.date     "approve_on"
    t.boolean  "agree"
    t.string   "explain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "manager"
  end

  create_table "budgets", :force => true do |t|
    t.integer  "category_id"
    t.integer  "period_id"
    t.decimal  "amount",      :precision => 10, :scale => 0
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "superior_id"
  end

  create_table "details", :force => true do |t|
    t.integer  "reimbursement_id"
    t.integer  "category_id"
    t.string   "name"
    t.integer  "amount"
    t.string   "unit"
    t.decimal  "unit_price",       :precision => 10, :scale => 2
    t.decimal  "price",            :precision => 10, :scale => 2
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "details", ["category_id"], :name => "index_details_on_category_id"
  add_index "details", ["reimbursement_id"], :name => "index_details_on_reimbursement_id"

  create_table "expenses", :force => true do |t|
    t.string   "sn"
    t.date     "request_on"
    t.string   "staff"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "status"
    t.integer  "organization_id"
    t.text     "explain"
    t.string   "abstract"
  end

  create_table "items", :force => true do |t|
    t.integer  "expense_id"
    t.string   "name"
    t.integer  "amount"
    t.string   "unit"
    t.decimal  "unit_price",  :precision => 10, :scale => 2
    t.decimal  "price",       :precision => 10, :scale => 2
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "category_id"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "superior_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "code"
    t.string   "kind"
    t.integer  "upper_manager_id"
  end

  create_table "periods", :force => true do |t|
    t.integer  "year"
    t.string   "explain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reimbursements", :force => true do |t|
    t.string   "sn"
    t.date     "reimburse_on"
    t.string   "staff"
    t.string   "status"
    t.integer  "organization_id"
    t.string   "abstract"
    t.decimal  "amount",          :precision => 10, :scale => 2
    t.integer  "expense_id"
    t.string   "invoice_no"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "displayname"
    t.string   "password_digest"
    t.boolean  "enabled"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "roles_mask"
  end

end
