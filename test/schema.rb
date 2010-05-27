# Test Schema

ActiveRecord::Schema.define(:version => 0) do
	create_table "blog_comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.integer  "user_id"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.string   "name"
    t.string   "site_url"
    t.string   "email"
    t.text     "body"
    t.datetime "created_at"
  end

  add_index "blog_comments", ["blog_post_id"], :name => "index_blog_comments_on_blog_post_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "title",                           :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",    :default => false, :null => false
    t.integer  "user_id"
    t.datetime "published_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "email",                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.boolean  "admin",             :default => false, :null => false
    t.string   "perishable_token",  :default => "",    :null => false
  end

end