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

ActiveRecord::Schema.define(:version => 20130522075909) do

  create_table "bonus", :force => true do |t|
    t.float    "amount"
    t.date     "distribution_date"
    t.text     "comment"
    t.integer  "employee_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "bonus", ["employee_id"], :name => "index_bonus_on_employee_id"

  create_table "contracts", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.float    "salary"
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "contracts", ["employee_id"], :name => "index_contracts_on_employee_id"

  create_table "discussions", :force => true do |t|
    t.text     "content"
    t.boolean  "is_visible"
    t.integer  "salary_activity_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "discussions", ["salary_activity_id"], :name => "index_discussions_on_salary_activity_id"

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.date     "birthdate"
    t.date     "originate_start_date"
    t.date     "originate_end_date"
    t.boolean  "current_employee"
    t.integer  "years_prior_exp"
    t.string   "university"
    t.string   "degree"
    t.boolean  "is_system_admin"
    t.boolean  "is_admin"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "employees", ["email"], :name => "index_employees_on_email", :unique => true
  add_index "employees", ["reset_password_token"], :name => "index_employees_on_reset_password_token", :unique => true

  create_table "salary_activities", :force => true do |t|
    t.float    "previous_salary"
    t.float    "current_salary"
    t.integer  "contract_id"
    t.date     "discusstion_date"
    t.date     "effective_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "salary_activities", ["contract_id"], :name => "index_salary_activities_on_contract_id"

end
