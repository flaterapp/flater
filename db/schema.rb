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

ActiveRecord::Schema.define(version: 2019_05_31_100114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.boolean "validated"
    t.bigint "task_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_assignments_on_task_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "dossiers", force: :cascade do |t|
    t.bigint "rental_id"
    t.bigint "candidate_id"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "tax_proof"
    t.float "monthly_revenues"
    t.string "revenues_proof"
    t.string "activity"
    t.string "activity_proof"
    t.string "identity_proof"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_dossiers_on_candidate_id"
    t.index ["rental_id"], name: "index_dossiers_on_rental_id"
  end

  create_table "flats", force: :cascade do |t|
    t.string "address"
    t.bigint "owner_id"
    t.boolean "to_rent"
    t.string "a_type"
    t.float "surface"
    t.integer "nb_rooms"
    t.boolean "furnished"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["owner_id"], name: "index_flats_on_owner_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "flat_id"
    t.bigint "tenant_id"
    t.text "description"
    t.boolean "pending"
    t.date "start_date"
    t.date "end_date"
    t.float "initial_rent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_rentals_on_flat_id"
    t.index ["tenant_id"], name: "index_rentals_on_tenant_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "action"
    t.date "date"
    t.time "time"
    t.string "status"
    t.integer "price"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.bigint "rental_id"
    t.string "complementary_info"
    t.index ["rental_id"], name: "index_tasks_on_rental_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "phone"
    t.date "birthdate"
    t.string "sex"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignments", "tasks"
  add_foreign_key "assignments", "users"
  add_foreign_key "dossiers", "rentals"
  add_foreign_key "dossiers", "users", column: "candidate_id"
  add_foreign_key "flats", "users", column: "owner_id"
  add_foreign_key "rentals", "flats"
  add_foreign_key "rentals", "users", column: "tenant_id"
  add_foreign_key "tasks", "rentals"
  add_foreign_key "tasks", "users"
end
