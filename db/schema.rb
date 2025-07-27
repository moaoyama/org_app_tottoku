# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_27_135429) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_logs", force: :cascade do |t|
    t.bigint "admin_id"
    t.string "action"
    t.string "target_table"
    t.bigint "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.bigint "gpt_result_id", null: false
    t.string "title"
    t.string "location"
    t.string "ai_decision"
    t.text "user_comment"
    t.string "user_override"
    t.datetime "expires_at"
    t.boolean "is_deleted"
    t.datetime "deleted_at"
    t.text "ocr_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_documents_on_category_id"
    t.index ["gpt_result_id"], name: "index_documents_on_gpt_result_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "gpt_results", force: :cascade do |t|
    t.string "storage_decision"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "documents", "categories"
  add_foreign_key "documents", "gpt_results"
  add_foreign_key "documents", "users"
end
