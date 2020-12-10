class SiasScale < ApplicationRecord
  include Scope

  MOTOR_FUNCTION_ATTRIBUTES = [
    "shoulder_motor_function",
    "finger_motor_function",
    "hip_motor_function",
    "knee_motor_function",
    "foot_motor_function",
  ].map(&:freeze).freeze

  TONE_REFLEX_ATTRIBUTES = [
    "upper_limb_muscle_tone",
    "lower_limb_muscle_tone",
    "upper_limb_tendon_reflex",
    "lower_limb_tendon_reflex",
  ].map(&:freeze).freeze

  SENSATION_ATTRIBUTES = [
    "upper_limb_tactile",
    "lower_limb_tactile",
    "upper_limb_sense_of_position",
    "lower_limb_sense_of_position",
  ].map(&:freeze).freeze

  ROM_PAIN_ATTRIBUTES = [
    "shoulder_joint_rom",
    "knee_joint_rom",
    "pain",
  ].map(&:freeze).freeze

  TRUNK_FUNCTION_ATTRIBUTES = [
    "trunk_verticality",
    "abdominal_mmt",
  ].map(&:freeze).freeze

  HIGHER_BRAIN_FUNCTION_ATTRIBUTES = [
    "visuospatial_cognition",
    "speech",
  ].map(&:freeze).freeze

  HEALTHY_SIDE_FUNCTION_ATTRIBUTES = [
    "gripstrength",
    "quadriceps_mmt",
  ].map(&:freeze).freeze

  belongs_to :patient
  enum shoulder_motor_function: {
    undefined: nil,
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum finger_motor_function: {
    undefined: nil,
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
    undefined: nil,
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum knee_motor_function: {
    undefined: nil,
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum foot_motor_function: {
    undefined: nil,
    no_function: 0,
    move_slightly: 1,
    move_a_little: 2,
    awkward: 3,
    a_little_awkward: 4,
    normal: 5,
  }, _prefix: true
  enum upper_limb_muscle_tone: {
    undefined: nil,
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum lower_limb_muscle_tone: {
    undefined: nil,
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum upper_limb_tendon_reflex: {
    undefined: nil,
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum lower_limb_tendon_reflex: {
    undefined: nil,
    hypertonia: 0,
    moderate_hypertonia: 1.0,
    hypotonia: 1.5,
    a_little_hypertonia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum upper_limb_tactile: {
    undefined: nil,
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum lower_limb_tactile: {
    undefined: nil,
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum upper_limb_sense_of_position: {
    undefined: nil,
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum lower_limb_sense_of_position: {
    undefined: nil,
    loss_of_sensation: 0,
    moderate_decline: 1,
    milde_decline: 2,
    normal: 3,
  }, _prefix: true
  enum shoulder_joint_rom: {
    undefined: nil,
    significant_limit: 0,
    moderate_limit: 1,
    milde_limit: 2,
    normal: 3,
  }, _prefix: true
  enum knee_joint_rom: {
    undefined: nil,
    significant_limit: 0,
    moderate_limit: 1,
    milde_limit: 2,
    normal: 3,
  }, _prefix: true
  enum pain: {
    undefined: nil,
    significant: 0,
    moderate: 1,
    milde: 2,
    normal: 3,
  }, _prefix: true
  enum trunk_verticality: {
    undefined: nil,
    impossible: 0,
    need_assistance: 1,
    almost_possible: 2,
    normal: 3,
  }, _prefix: true
  enum abdominal_mmt: {
    undefined: nil,
    impossible: 0,
    slightly_possible: 1,
    almost_possible: 2,
    normal: 3,
  }, _prefix: true
  enum visuospatial_cognition: {
    undefined: nil,
    large_error: 0,
    moderate_error: 1,
    a_little_error: 2,
    very_slight_error: 3,
  }, _prefix: true
  enum speech: {
    undefined: nil,
    all_aphasia: 0,
    severe_expressive_aphasia: 1.0,
    severe_sensory_aphasia: 1.4,
    mild_aphasia: 2.0,
    normal: 3.0,
  }, _prefix: true
  enum gripstrength: {
    undefined: nil,
    zero: 0,
    poor: 1,
    fair: 2,
    normal: 3,
  }, _prefix: true
  enum quadriceps_mmt: {
    undefined: nil,
    zero: 0,
    poor: 1,
    fair: 2,
    normal: 3,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.sias_scale.#{attr_name}.#{k}"), k] }
  end
end
