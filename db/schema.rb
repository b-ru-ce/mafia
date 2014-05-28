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

ActiveRecord::Schema.define(version: 20140528091528) do

  create_table "articles", force: true do |t|
    t.text     "title"
    t.date     "date"
    t.string   "image_uid"
    t.text     "short_text"
    t.text     "text"
    t.string   "title_of_window"
    t.text     "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "usefull"
  end

  create_table "articles_categories", force: true do |t|
    t.integer  "article_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "title"
    t.integer  "sort"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry"

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "my_configs", force: true do |t|
    t.string   "key"
    t.string   "key_ru"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.string   "purpose"
    t.boolean  "show_in_menu"
    t.string   "menu"
    t.text     "meta"
    t.string   "title_of_window"
    t.string   "ancestry"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["ancestry"], name: "index_pages_on_ancestry"

  create_table "photo_galleries", force: true do |t|
    t.text     "title"
    t.integer  "sort"
    t.string   "ancestry"
    t.string   "title_of_window"
    t.text     "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
    t.date     "date"
  end

  add_index "photo_galleries", ["ancestry"], name: "index_photo_galleries_on_ancestry"

  create_table "photos", force: true do |t|
    t.integer  "photo_gallery_id"
    t.string   "image_uid"
    t.text     "description"
    t.integer  "sort"
    t.string   "ancestry"
    t.boolean  "main"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["ancestry"], name: "index_photos_on_ancestry"

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", force: true do |t|
    t.text     "title"
    t.string   "image_uid"
    t.text     "text"
    t.string   "url"
    t.integer  "sort"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slides", ["ancestry"], name: "index_slides_on_ancestry"

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
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
