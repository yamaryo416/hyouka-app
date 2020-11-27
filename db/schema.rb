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

ActiveRecord::Schema.define(version: 2020_11_27_092822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brs_scales", force: :cascade do |t|
    t.integer "upper_limbs"
    t.integer "finger"
    t.integer "lower_limbs"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_brs_scales_on_patient_id"
  end

  create_table "fbs_scales", force: :cascade do |t|
    t.integer "stand_up"
    t.integer "standing"
    t.integer "sitting"
    t.integer "sit_down"
    t.integer "transfer"
    t.integer "standing_with_eyes_close"
    t.integer "standing_with_leg_close"
    t.integer "reach_forward"
    t.integer "pickup_from_floor"
    t.integer "turn_around"
    t.integer "one_rotation"
    t.integer "stepup_and_down"
    t.integer "tandem_standing"
    t.integer "standing_with_one_leg"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_fbs_scales_on_patient_id"
  end

  create_table "mas_scales", force: :cascade do |t|
    t.integer "elbow_joint"
    t.integer "wrist_joint"
    t.integer "knee_joint"
    t.integer "ankle_joint"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_mas_scales_on_patient_id"
  end

  create_table "mmt_scales", force: :cascade do |t|
    t.integer "neck_flexion"
    t.integer "neck_extension"
    t.integer "trunk_flexion"
    t.integer "trunk_extension"
    t.integer "right_shoulder_flexion"
    t.integer "left_shoulder_flexion"
    t.integer "right_shoulder_extension"
    t.integer "left_shoulder_extension"
    t.integer "right_shoulder_abduction"
    t.integer "left_shoulder_abduction"
    t.integer "right_shoulder_horizontal_adduction"
    t.integer "left_shoulder_horizontal_adduction"
    t.integer "right_shoulder_horizontal_abduction"
    t.integer "left_shoulder_horizontal_abduction"
    t.integer "right_shoulder_internal_rotation"
    t.integer "left_shoulder_internal_rotation"
    t.integer "right_shoulder_external_rotation"
    t.integer "left_shoulder_external_rotation"
    t.integer "right_elbow_flexion"
    t.integer "left_elbow_flexion"
    t.integer "right_elbow_extension"
    t.integer "left_elbow_extension"
    t.integer "right_forearm_pronation"
    t.integer "left_forearm_pronation"
    t.integer "right_forearm_supination"
    t.integer "left_forearm_supination"
    t.integer "right_wrist_flexion"
    t.integer "left_wrist_flexion"
    t.integer "right_wrist_extension"
    t.integer "left_wrist_extension"
    t.integer "right_first_hip_flexion"
    t.integer "left_first_hip_flexion"
    t.integer "right_second_hip_flexion"
    t.integer "left_second_hip_flexion"
    t.integer "right_first_hip_extension"
    t.integer "left_first_hip_extension"
    t.integer "right_second_hip_extension"
    t.integer "left_second_hip_extension"
    t.integer "right_hip_adduction"
    t.integer "left_hip_adduction"
    t.integer "right_first_hip_abduction"
    t.integer "left_first_hip_abduction"
    t.integer "right_second_hip_abduction"
    t.integer "left_second_hip_abduction"
    t.integer "right_hip_internal_rotation"
    t.integer "left_hip_internal_rotation"
    t.integer "right_hip_external_rotation"
    t.integer "left_hip_external_rotation"
    t.integer "right_knee_flexion"
    t.integer "left_knee_flexion"
    t.integer "right_knee_extension"
    t.integer "left_knee_extension"
    t.integer "right_ankle_flexion"
    t.integer "left_ankle_flexion"
    t.float "right_ankle_extension"
    t.float "left_ankle_extension"
    t.integer "right_ankle_pronation"
    t.integer "left_ankle_pronation"
    t.integer "right_ankle_supination"
    t.integer "left_ankle_supination"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_mmt_scales_on_patient_id"
  end

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

  create_table "rom_scales", force: :cascade do |t|
    t.integer "right_shoulder_flexion"
    t.integer "left_shoulder_flexion"
    t.integer "right_shoulder_extension"
    t.integer "left_shoulder_extension"
    t.integer "right_shoulder_adduction"
    t.integer "left_shoulder_adduction"
    t.integer "right_shoulder_abduction"
    t.integer "left_shoulder_abduction"
    t.integer "right_first_shoulder_internal_rotation"
    t.integer "left_first_shoulder_internal_rotation"
    t.integer "right_first_shoulder_external_rotation"
    t.integer "left_first_shoulder_external_rotation"
    t.integer "right_second_shoulder_internal_rotation"
    t.integer "left_second_shoulder_internal_rotation"
    t.integer "right_second_shoulder_external_rotation"
    t.integer "left_second_shoulder_external_rotation"
    t.integer "right_third_shoulder_internal_rotation"
    t.integer "left_third_shoulder_internal_rotation"
    t.integer "right_third_shoulder_external_rotation"
    t.integer "left_third_shoulder_external_rotation"
    t.integer "right_elbow_flexion"
    t.integer "left_elbow_flexion"
    t.integer "right_elbow_extension"
    t.integer "left_elbow_extension"
    t.integer "right_forearm_pronation"
    t.integer "left_forearm_pronation"
    t.integer "right_forearm_supination"
    t.integer "left_forearm_supination"
    t.integer "right_wrist_flexion"
    t.integer "left_wrist_flexion"
    t.integer "right_wrist_extension"
    t.integer "left_wrist_extension"
    t.integer "right_wrist_adduction"
    t.integer "left_wrist_adduction"
    t.integer "right_wrist_abduction"
    t.integer "left_wrist_abduction"
    t.integer "right_hip_flexion"
    t.integer "left_hip_flexion"
    t.integer "right_hip_extension"
    t.integer "left_hip_extension"
    t.integer "right_hip_adduction"
    t.integer "left_hip_adduction"
    t.integer "right_hip_abduction"
    t.integer "left_hip_abduction"
    t.integer "right_hip_internal_rotation"
    t.integer "left_hip_internal_rotation"
    t.integer "right_hip_external_rotation"
    t.integer "left_hip_external_rotation"
    t.integer "right_knee_flexion"
    t.integer "left_knee_flexion"
    t.integer "right_knee_extension"
    t.integer "left_knee_extension"
    t.integer "right_first_ankle_flexion"
    t.integer "left_first_ankle_flexion"
    t.integer "right_second_ankle_flexion"
    t.integer "left_second_ankle_flexion"
    t.integer "right_ankle_extension"
    t.integer "left_ankle_extension"
    t.integer "right_ankle_adduction"
    t.integer "left_ankle_adduction"
    t.integer "right_ankle_abduction"
    t.integer "left_ankle_abduction"
    t.integer "right_ankle_pronation"
    t.integer "left_ankle_pronation"
    t.integer "right_ankle_supination"
    t.integer "left_ankle_supination"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_rom_scales_on_patient_id"
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

  add_foreign_key "brs_scales", "patients"
  add_foreign_key "fbs_scales", "patients"
  add_foreign_key "mas_scales", "patients"
  add_foreign_key "mmt_scales", "patients"
  add_foreign_key "patients", "therapists"
  add_foreign_key "rom_scales", "patients"
  add_foreign_key "sias_scales", "patients"
end
