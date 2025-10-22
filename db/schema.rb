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

ActiveRecord::Schema[8.0].define(version: 2025_10_21_152852) do
  create_table "analyses", force: :cascade do |t|
    t.integer "analysis_type"
    t.json "parameters"
    t.json "results"
    t.integer "status"
    t.integer "credit_cost"
    t.datetime "executed_at"
    t.integer "project_id", null: false
    t.integer "survey_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_analyses_on_project_id"
    t.index ["survey_id"], name: "index_analyses_on_survey_id"
  end

  create_table "credit_transactions", force: :cascade do |t|
    t.integer "transaction_type"
    t.integer "amount"
    t.integer "balance_after"
    t.string "description"
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_credit_transactions_on_project_id"
    t.index ["user_id"], name: "index_credit_transactions_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "status"
    t.integer "credit_allocated"
    t.integer "credit_used"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "participant_id"
    t.json "response_data"
    t.datetime "completed_at"
    t.integer "survey_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_responses_on_survey_id"
  end

  create_table "scale_items", force: :cascade do |t|
    t.text "content"
    t.integer "item_type"
    t.integer "order"
    t.json "options"
    t.integer "scale_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scale_id"], name: "index_scale_items_on_scale_id"
  end

  create_table "scales", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "doi_identifier"
    t.string "version"
    t.string "language"
    t.string "category"
    t.integer "item_count"
    t.text "metadata", default: "{}"
    t.integer "status"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scales_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "distribution_mode"
    t.integer "status"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "settings", default: "{}"
    t.integer "project_id", null: false
    t.integer "scale_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_surveys_on_project_id"
    t.index ["scale_id"], name: "index_surveys_on_scale_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.integer "role"
    t.integer "credits_balance"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "analyses", "projects"
  add_foreign_key "analyses", "surveys"
  add_foreign_key "credit_transactions", "projects"
  add_foreign_key "credit_transactions", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "responses", "surveys"
  add_foreign_key "scale_items", "scales"
  add_foreign_key "scales", "users"
  add_foreign_key "surveys", "projects"
  add_foreign_key "surveys", "scales"
end
