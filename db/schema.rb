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

ActiveRecord::Schema.define(version: 2020_11_14_114448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "patients", force: :cascade do |t|
    t.string "unique_id", default: "", null: false
    t.integer "age", default: 0
    t.integer "sex"
    t.float "weight"
    t.float "height"
    t.bigint "therapist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["therapist_id", "created_at"], name: "index_patients_on_therapist_id_and_created_at"
    t.index ["therapist_id"], name: "index_patients_on_therapist_id"
    t.index ["unique_id"], name: "index_patients_on_unique_id", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sias_scales", force: :cascade do |t|
    t.integer "shoulder_motor_function"
    t.float "finger_motor_function"
    t.integer "hip_motor_function"
    t.integer "knee_motor_function"
    t.integer "foot_motor_function"
    t.float "upper_limb_muscle_tone"
    t.float "lower_limb_muscle_tone"
    t.float "upper_limb_tendon_reflex"
    t.float "lower_limb_tendon_reflex"
    t.integer "upper_limb_tactile"
    t.integer "lower_limb_tactile"
    t.integer "upper_limb_sense_of_position"
    t.integer "lower_limb_sense_of_position"
    t.integer "shoulder_joint_rom"
    t.integer "knee_joint_rom"
    t.integer "pain"
    t.integer "trunk_verticality"
    t.integer "abdominal_mmt"
    t.integer "visuospatial_cognition"
    t.float "speech"
    t.integer "gripstrength"
    t.integer "quadriceps_mmt"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_sias_scales_on_patient_id"
  end

  create_table "therapists", force: :cascade do |t|
    t.string "unique_id", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reset_password_token"], name: "index_therapists_on_reset_password_token", unique: true
    t.index ["unique_id"], name: "index_therapists_on_unique_id", unique: true
  end

  create_table "therapists_roles", id: false, force: :cascade do |t|
    t.bigint "therapist_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_therapists_roles_on_role_id"
    t.index ["therapist_id", "role_id"], name: "index_therapists_roles_on_therapist_id_and_role_id"
    t.index ["therapist_id"], name: "index_therapists_roles_on_therapist_id"
  end

  add_foreign_key "patients", "therapists"
  add_foreign_key "sias_scales", "patients"
end
