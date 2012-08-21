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

ActiveRecord::Schema.define(:version => 20120821214809) do

  create_table "economic_categories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "economic_category_translations", :force => true do |t|
    t.integer  "economic_category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "economic_category_translations", ["economic_category_id"], :name => "index_52085465f9885e100d1dc9141140c40ae624440c"
  add_index "economic_category_translations", ["locale"], :name => "index_economic_category_translations_on_locale"
  add_index "economic_category_translations", ["name"], :name => "index_economic_category_translations_on_name"

  create_table "indicator_categories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indicator_category_translations", :force => true do |t|
    t.integer  "indicator_category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicator_category_translations", ["indicator_category_id"], :name => "index_84a465525dc238cb39142b055e1656d812ba4e21"
  add_index "indicator_category_translations", ["locale"], :name => "index_indicator_category_translations_on_locale"
  add_index "indicator_category_translations", ["name"], :name => "index_indicator_category_translations_on_name"

  create_table "indicator_translations", :force => true do |t|
    t.integer  "indicator_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicator_translations", ["indicator_id"], :name => "index_indicator_translations_on_indicator_id"
  add_index "indicator_translations", ["locale"], :name => "index_indicator_translations_on_locale"
  add_index "indicator_translations", ["name"], :name => "index_indicator_translations_on_name"

  create_table "indicators", :force => true do |t|
    t.integer  "indicator_category_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicators", ["indicator_category_id", "value"], :name => "index_indicators_on_indicator_category_id_and_value"

  create_table "political_parties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "political_party_translations", :force => true do |t|
    t.integer  "political_party_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "political_party_translations", ["locale"], :name => "index_political_party_translations_on_locale"
  add_index "political_party_translations", ["name"], :name => "index_political_party_translations_on_name"
  add_index "political_party_translations", ["political_party_id"], :name => "index_d74f39ea82f0f6fcd074b03ad118d440ba291333"

  create_table "statement_scores", :force => true do |t|
    t.integer  "statement_id"
    t.integer  "indicator_category_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "indicator_id"
  end

  add_index "statement_scores", ["statement_id", "indicator_category_id", "indicator_id", "value"], :name => "statement_score_record"

  create_table "statement_translations", :force => true do |t|
    t.integer  "statement_id"
    t.string   "locale"
    t.text     "statement_made"
    t.string   "source"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "analysis"
  end

  add_index "statement_translations", ["author"], :name => "index_statement_translations_on_author"
  add_index "statement_translations", ["locale"], :name => "index_statement_translations_on_locale"
  add_index "statement_translations", ["source"], :name => "index_statement_translations_on_source"
  add_index "statement_translations", ["statement_id"], :name => "index_statement_translations_on_statement_id"

  create_table "statements", :force => true do |t|
    t.date     "date_made"
    t.integer  "political_party_id"
    t.integer  "economic_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statements", ["date_made"], :name => "index_statements_on_date_made"
  add_index "statements", ["political_party_id", "economic_category_id"], :name => "index_statements_on_political_party_id_and_economic_category_id"

  create_table "users", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
