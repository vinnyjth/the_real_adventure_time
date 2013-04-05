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

ActiveRecord::Schema.define(:version => 20130404131356) do

  create_table "adventures", :force => true do |t|
    t.string   "name"
    t.boolean  "male"
    t.integer  "route"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.text     "content"
    t.date     "date"
    t.string   "stamp"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "paths", :force => true do |t|
    t.integer  "page_from_id"
    t.integer  "page_to_id"
    t.string   "question"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end