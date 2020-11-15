class SiasScale < ApplicationRecord
  belongs_to :patient
  enum shoulder_motor_function: {
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum finger_motor_function: {
    no_function: 0,
    move_slightly: 1.0,
    group_extension_possible: 1.3,
    partial_separation_possible: 1.6,
    move_a_little: 2.0,
    awkward: 3.0,
    a_little_awkward: 4.0,
    normal: 5.0,
  }, _prefix: true
  enum hip_motor_function: {
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum knee_motor_function: {
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum foot_motor_function: {
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum upper_limb_muscle_tone: {
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum lower_limb_muscle_tone: {
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum upper_limb_tendon_reflex: {
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum lower_limb_tendon_reflex: {
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum upper_limb_tactile: {
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum lower_limb_tactile: {
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum upper_limb_sense_of_position: {
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum lower_limb_sense_of_position: {
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum shoulder_joint_rom: {
    significant_limit: 0,
    moderate_limit: 1,
    milde_limit: 2,
    normal: 3,
  }, _prefix: true
  enum knee_joint_rom: {
    significant_limit: 0,
    moderate_limit: 1,
    milde_limit: 2,
    normal: 3,
  }, _prefix: true
  enum pain: {
    significant: 0,
    moderate: 1,
    milde: 2,
    normal: 3,
  }, _prefix: true
  enum trunk_verticality: {
    impossible: 0,
    need_assistance: 1,
    almost_possible: 2,
    normal: 3,
  }, _prefix: true
  enum abdominal_mmt: {
    impossible: 0,
    slightly_possible: 1,
    almost_possible: 2,
    normal: 3,
  }, _prefix: true
  enum visuospatial_cognition: {
    large_error: 0,
    moderate_error: 1,
    a_little_error: 2,
    very_slight_error: 3,
  }, _prefix: true
  enum speech: {
    all_aphasia: 0,
    severe_expressive_aphasia: 1.3,
    severe_sensory_aphasia: 1.4,
    mild_aphasia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum gripstrength: {
    zero: 0,
    poor: 1,
    fair: 2,
    normal: 3,
  }, _prefix: true
  enum quadriceps_mmt: {
    zero: 0,
    poor: 1,
    fair: 2,
    normal: 3,
  }, _prefix: true
end
