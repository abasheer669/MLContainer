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

ActiveRecord::Schema[7.0].define(version: 2023_08_08_071758) do
  create_table "activities", force: :cascade do |t|
    t.integer "container_id", null: false
    t.integer "activity_type"
    t.integer "activity_status"
    t.integer "user_id", null: false
    t.float "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "activity_date"
    t.index ["container_id"], name: "index_activities_on_container_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "file_type"
    t.string "attachable_type", null: false
    t.integer "attachable_id", null: false
    t.string "pre_signed_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id", null: false
    t.string "commentable_type", null: false
    t.integer "commentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "container_heights", force: :cascade do |t|
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "container_lengths", force: :cascade do |t|
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "containers", force: :cascade do |t|
    t.integer "yardname_id", null: false
    t.string "submitter_initial"
    t.integer "container_height_id", null: false
    t.integer "container_length_id", null: false
    t.string "container_number"
    t.string "location"
    t.integer "container_type"
    t.integer "customer_id", null: false
    t.integer "manufacture_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "container_owner_name"
    t.index ["container_height_id"], name: "index_containers_on_container_height_id"
    t.index ["container_length_id"], name: "index_containers_on_container_length_id"
    t.index ["customer_id"], name: "index_containers_on_customer_id"
    t.index ["yardname_id"], name: "index_containers_on_yardname_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "owner_name"
    t.string "billing_name"
    t.float "hourly_rate"
    t.float "gst"
    t.float "pst"
    t.string "city"
    t.string "province"
    t.string "postalcode"
    t.integer "customer_type"
    t.string "password"
    t.integer "customer_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "damage_area"
    t.text "comment"
    t.float "quantity"
    t.float "labour_cost"
    t.float "material_cost"
    t.float "total_cost"
    t.string "location"
    t.string "container_type"
    t.string "container_repair_area"
    t.integer "repair_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "activity_id", null: false
    t.index ["activity_id"], name: "index_items_on_activity_id"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "user_id", null: false
    t.integer "log_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_logs_on_activity_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "user_type"
    t.string "name"
    t.string "phone_number"
    t.string "password"
    t.integer "user_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "yardnames", force: :cascade do |t|
    t.string "yard_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "containers"
  add_foreign_key "activities", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "containers", "container_heights"
  add_foreign_key "containers", "container_lengths"
  add_foreign_key "containers", "customers"
  add_foreign_key "containers", "yardnames"
  add_foreign_key "items", "activities"
  add_foreign_key "logs", "activities"
  add_foreign_key "logs", "users"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
