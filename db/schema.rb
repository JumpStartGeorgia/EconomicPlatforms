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

ActiveRecord::Schema.define(:version => 20131001140427) do

  create_table "activities", :force => true do |t|
    t.date     "date"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "election_id"
  end

  create_table "activity_images", :force => true do |t|
    t.integer  "activity_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_images", ["activity_id"], :name => "index_activity_images_on_activity_id"

  create_table "activity_translations", :force => true do |t|
    t.integer  "activity_id"
    t.string   "locale"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_translations", ["activity_id"], :name => "index_activity_translations_on_activity_id"
  add_index "activity_translations", ["locale"], :name => "index_activity_translations_on_locale"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vote"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

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
    t.string   "permalink"
  end

  add_index "economic_category_translations", ["economic_category_id"], :name => "index_52085465f9885e100d1dc9141140c40ae624440c"
  add_index "economic_category_translations", ["locale"], :name => "index_economic_category_translations_on_locale"
  add_index "economic_category_translations", ["name"], :name => "index_economic_category_translations_on_name"
  add_index "economic_category_translations", ["permalink"], :name => "index_economic_category_translations_on_permalink"

  create_table "election_translations", :force => true do |t|
    t.integer  "election_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "election_translations", ["election_id"], :name => "index_election_translations_on_election_id"
  add_index "election_translations", ["locale"], :name => "index_election_translations_on_locale"

  create_table "elections", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicator_translations", ["indicator_id"], :name => "index_indicator_translations_on_indicator_id"
  add_index "indicator_translations", ["locale"], :name => "index_indicator_translations_on_locale"

  create_table "indicators", :force => true do |t|
    t.integer  "indicator_category_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicators", ["indicator_category_id", "value"], :name => "index_indicators_on_indicator_category_id_and_value"

  create_table "page_files", :force => true do |t|
    t.integer  "page_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_files", ["page_id"], :name => "index_page_files_on_page_id"

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_translations", ["locale"], :name => "index_page_translations_on_locale"
  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["name"], :name => "index_pages_on_name"

  create_table "platform_files", :force => true do |t|
    t.integer  "platform_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "platform_files", ["platform_id"], :name => "index_platform_files_on_platform_id"

  create_table "platform_scores", :force => true do |t|
    t.integer  "platform_id"
    t.integer  "indicator_category_id"
    t.integer  "indicator_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "platform_scores", ["platform_id", "indicator_category_id", "indicator_id", "value"], :name => "platform_score_id_ind_cat_value"

  create_table "platform_translations", :force => true do |t|
    t.integer  "platform_id"
    t.string   "locale"
    t.text     "description", :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "platform_translations", ["locale"], :name => "index_platform_translations_on_locale"
  add_index "platform_translations", ["platform_id"], :name => "index_platform_translations_on_platform_id"

  create_table "platforms", :force => true do |t|
    t.integer  "political_party_id"
    t.integer  "economic_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_public",            :default => false
    t.string   "vote"
    t.integer  "election_id"
  end

  add_index "platforms", ["is_public"], :name => "index_platforms_on_is_public"
  add_index "platforms", ["political_party_id", "economic_category_id"], :name => "platform_party_ec_cat"

  create_table "policy_brief_translations", :force => true do |t|
    t.integer  "policy_brief_id"
    t.string   "locale"
    t.text     "analysis"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "policy_brief_translations", ["locale"], :name => "index_policy_brief_translations_on_locale"
  add_index "policy_brief_translations", ["policy_brief_id"], :name => "index_66fa1075ffd46e8c0f8d201837feaf3f9d24b8a1"

  create_table "policy_briefs", :force => true do |t|
    t.integer  "political_party_id"
    t.integer  "economic_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_public",            :default => false
    t.string   "vote"
    t.integer  "election_id"
  end

  add_index "policy_briefs", ["is_public"], :name => "index_policy_briefs_on_is_public"
  add_index "policy_briefs", ["political_party_id", "economic_category_id"], :name => "pol_briefs_party_ec_cat"

  create_table "political_parties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "election_id"
  end

  create_table "political_party_translations", :force => true do |t|
    t.integer  "political_party_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.text     "platform"
  end

  add_index "political_party_translations", ["locale"], :name => "index_political_party_translations_on_locale"
  add_index "political_party_translations", ["name"], :name => "index_political_party_translations_on_name"
  add_index "political_party_translations", ["permalink"], :name => "index_political_party_translations_on_permalink"
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
    t.boolean  "is_public",            :default => false
    t.string   "vote"
    t.integer  "election_id"
  end

  add_index "statements", ["date_made"], :name => "index_statements_on_date_made"
  add_index "statements", ["is_public"], :name => "index_statements_on_is_public"
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

  create_table "voter_ips", :force => true do |t|
    t.string   "ip",           :limit => 50, :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "status"
  end

end
