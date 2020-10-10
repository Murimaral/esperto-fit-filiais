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

ActiveRecord::Schema.define(version: 2020_10_09_223743) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "banned_customers", force: :cascade do |t|
    t.text "reason", null: false
    t.datetime "banned_at", null: false
    t.integer "user_id", null: false
    t.string "cpf", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cpf"], name: "index_banned_customers_on_cpf", unique: true
    t.index ["user_id"], name: "index_banned_customers_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.string "token"
    t.string "customer_name"
    t.string "customer_cpf"
    t.string "email"
    t.decimal "price"
    t.integer "status", default: 0
    t.date "valid_thru"
    t.integer "subsidiary_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subsidiary_plan_id"], name: "index_enrollments_on_subsidiary_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "default_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "minimum_period"
    t.index ["name"], name: "index_plans_on_name", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "min_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_products_on_name", unique: true
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
    t.index ["plan_id", "subsidiary_id"], name: "index_subsidiary_plans_on_plan_id_and_subsidiary_id", unique: true
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "banned_customers", "users"
  add_foreign_key "enrollments", "subsidiary_plans"
  add_foreign_key "profiles", "users"
  add_foreign_key "subsidiary_plans", "plans"
  add_foreign_key "subsidiary_plans", "subsidiaries"
end
