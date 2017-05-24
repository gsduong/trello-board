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

ActiveRecord::Schema.define(version: 20170516221253) do

  create_table "board_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "member_id",                 null: false
    t.integer  "board_id",                  null: false
    t.text     "description", limit: 65535, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["board_id"], name: "index_board_activities_on_board_id", using: :btree
  end

  create_table "board_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "board_id",                  null: false
    t.integer  "member_id",                 null: false
    t.boolean  "admin",      default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["board_id", "member_id"], name: "index_board_members_on_board_id_and_member_id", unique: true, using: :btree
    t.index ["board_id"], name: "index_board_members_on_board_id", using: :btree
  end

  create_table "boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "open",        default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["open"], name: "index_boards_on_open", using: :btree
  end

  create_table "card_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "member_id",                 null: false
    t.integer  "card_id",                   null: false
    t.text     "description", limit: 65535, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["card_id"], name: "index_card_activities_on_card_id", using: :btree
  end

  create_table "card_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "card_id",                    null: false
    t.integer  "commenter_id",               null: false
    t.text     "content",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["card_id"], name: "index_card_comments_on_card_id", using: :btree
  end

  create_table "card_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "card_id",    null: false
    t.integer  "member_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id", "member_id"], name: "index_card_members_on_card_id_and_member_id", unique: true, using: :btree
    t.index ["card_id"], name: "index_card_members_on_card_id", using: :btree
  end

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "list_id",                                  null: false
    t.string   "title",                                    null: false
    t.text     "description", limit: 65535
    t.datetime "due_date"
    t.boolean  "open",                      default: true, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["list_id"], name: "index_cards_on_list_id", using: :btree
  end

  create_table "lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "board_id",                  null: false
    t.string   "title"
    t.boolean  "open",       default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["board_id"], name: "index_lists_on_board_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "username"
    t.string   "email",           null: false
    t.string   "password_digest"
    t.string   "session_key"
    t.string   "activation_key"
    t.string   "bio"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["session_key"], name: "index_users_on_session_key", using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
