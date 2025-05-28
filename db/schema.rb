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

ActiveRecord::Schema[7.2].define(version: 2025_05_27_192013) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "section_students", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "student_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_section_students_on_section_id"
    t.index ["student_profile_id"], name: "index_section_students_on_student_profile_id"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "classroom_id", null: false
    t.bigint "teacher_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "monday_start"
    t.time "monday_end"
    t.time "tuesday_start"
    t.time "tuesday_end"
    t.time "wednesday_start"
    t.time "wednesday_end"
    t.time "thursday_start"
    t.time "thursday_end"
    t.time "friday_start"
    t.time "friday_end"
    t.time "saturday_start"
    t.time "saturday_end"
    t.time "sunday_start"
    t.time "sunday_end"
    t.index ["classroom_id"], name: "index_sections_on_classroom_id"
    t.index ["subject_id"], name: "index_sections_on_subject_id"
    t.index ["teacher_profile_id"], name: "index_sections_on_teacher_profile_id"
  end

  create_table "student_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teacher_profile_id"
    t.bigint "student_profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["student_profile_id"], name: "index_users_on_student_profile_id"
    t.index ["teacher_profile_id"], name: "index_users_on_teacher_profile_id"
  end

  add_foreign_key "section_students", "sections"
  add_foreign_key "section_students", "student_profiles"
  add_foreign_key "sections", "classrooms"
  add_foreign_key "sections", "subjects"
  add_foreign_key "sections", "teacher_profiles"
  add_foreign_key "users", "student_profiles"
  add_foreign_key "users", "teacher_profiles"
end
