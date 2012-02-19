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

ActiveRecord::Schema.define(:version => 20120219224223) do

  create_table "food_visits", :force => true do |t|
    t.integer  "order_number"
    t.boolean  "food_in"
    t.integer  "number_of_adults"
    t.integer  "number_of_children"
    t.integer  "number_of_elderly"
    t.text     "special_needs"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "gender"
    t.decimal  "ssn"
    t.string   "housing"
    t.date     "date_of_birth"
    t.text     "address"
    t.string   "ethnicity"
    t.string   "family_type"
    t.string   "education"
    t.boolean  "health_insurance"
    t.boolean  "drug_history"
    t.boolean  "criminal_background"
    t.integer  "people_in_house"
    t.integer  "employment_income"
    t.integer  "ssi"
    t.integer  "ssd"
    t.integer  "welfare"
    t.text     "other"
    t.integer  "child_support"
    t.integer  "food_stamps"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
