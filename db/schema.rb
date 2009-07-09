# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090709025144) do

  create_table "admin_users", :force => true do |t|
    t.string   "login_account", :limit => 45
    t.string   "pass",          :limit => 45
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lock_version"
    t.boolean  "delete_flg",                  :default => false
  end

  create_table "design_themes", :force => true do |t|
    t.binary   "image",                           :null => false
    t.boolean  "delete_flg",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.integer  "mutter_id",                       :null => false
    t.boolean  "delete_flg",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

  create_table "follows", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "follow_user_id",                    :null => false
    t.boolean  "delete_flg",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

  create_table "mails", :force => true do |t|
    t.integer  "send_user_id",                              :null => false
    t.integer  "receive_user_id",                           :null => false
    t.integer  "return_mails_id",                           :null => false
    t.integer  "res_flg",                                   :null => false
    t.integer  "direct_receive_mail_id"
    t.text     "message"
    t.boolean  "delete_flg",             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

  create_table "mutters", :force => true do |t|
    t.integer  "user_id",                              :null => false
    t.integer  "res_flg"
    t.integer  "return_mutters_id"
    t.text     "mutter"
    t.binary   "image"
    t.boolean  "delete_flg",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

  create_table "news_letters", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.boolean  "preview_flg"
    t.boolean  "delete_flg",   :default => false
    t.datetime "send_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

  create_table "return_mails", :force => true do |t|
    t.integer  "mail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
    t.boolean  "delete_flg",   :default => false
  end

  create_table "return_mutters", :force => true do |t|
    t.integer  "mutter_id",                       :null => false
    t.boolean  "delete_flg",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

  create_table "users", :force => true do |t|
    t.string   "pass",                                 :null => false
    t.string   "name",                                 :null => false
    t.string   "mail",                                 :null => false
    t.string   "other_url"
    t.string   "self_introduction"
    t.string   "now_place"
    t.boolean  "follow_news_flg"
    t.boolean  "dm_news_flg"
    t.boolean  "nesw_letter_flg"
    t.binary   "design_theme_id"
    t.binary   "icon_image_id"
    t.boolean  "delete_flg",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
  end

end
