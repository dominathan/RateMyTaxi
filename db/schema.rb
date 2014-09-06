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

ActiveRecord::Schema.define(version: 20140906155314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "content"
    t.string   "answer_type"
    t.integer  "review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["review_id"], name: "index_questions_on_review_id", using: :btree

  create_table "reviews", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taxi_id"
    t.integer  "user_id"
  end

  add_index "reviews", ["taxi_id"], name: "index_reviews_on_taxi_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "taxis", force: true do |t|
    t.integer  "user_id"
    t.string   "driver_first_name"
    t.string   "driver_last_name"
    t.string   "driver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taxis", ["user_id"], name: "index_taxis_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "company_name"
    t.integer  "taxi_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
