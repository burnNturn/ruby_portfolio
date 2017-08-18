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

ActiveRecord::Schema.define(version: 20170809191451) do

  create_table "holdings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "security_id"
    t.string   "symbol"
    t.string   "asset_class"
    t.decimal  "quantity"
    t.date     "date_opened"
    t.decimal  "cost_basis"
    t.decimal  "avg_price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "holdings", ["portfolio_id"], name: "index_holdings_on_portfolio_id"
  add_index "holdings", ["security_id"], name: "index_holdings_on_security_id"
  add_index "holdings", ["user_id"], name: "index_holdings_on_user_id"

  create_table "portfolios", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.decimal  "total_value"
    t.decimal  "equities_value"
    t.decimal  "cash_balance"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id"

  create_table "securities", force: :cascade do |t|
    t.string   "symbol"
    t.string   "asset_class"
    t.string   "description"
    t.string   "identifier"
    t.decimal  "previous_close"
    t.decimal  "current_price"
    t.datetime "last_api_call"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "holding_id"
    t.integer  "portfolio_id"
    t.date     "date"
    t.string   "activity"
    t.decimal  "quantity"
    t.string   "symbol"
    t.string   "description"
    t.decimal  "price"
    t.decimal  "commission"
    t.decimal  "fees"
    t.decimal  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
