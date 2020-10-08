# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_06_200241) do

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "default_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "minimum_period"
    t.index ["name"], name: "index_plans_on_name", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "cpf"
    t.text "address"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "subsidiaries", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cnpj"
    t.string "token"
    t.index ["cnpj"], name: "index_subsidiaries_on_cnpj", unique: true
    t.index ["name"], name: "index_subsidiaries_on_name", unique: true
    t.index ["token"], name: "index_subsidiaries_on_token", unique: true
  end

  create_table "subsidiary_plans", force: :cascade do |t|
    t.integer "subsidiary_id", null: false
    t.integer "plan_id", null: false
    t.integer "status", default: 0
    t.decimal "final_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_subsidiary_plans_on_plan_id"
    t.index ["subsidiary_id"], name: "index_subsidiary_plans_on_subsidiary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "subsidiary_plans", "plans"
  add_foreign_key "subsidiary_plans", "subsidiaries"
end
