class MmtScale < ApplicationRecord
  include Scope

  belongs_to :patient
  enum neck_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum neck_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum trunk_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum trunk_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_shoulder_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_shoulder_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_shoulder_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_shoulder_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_shoulder_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_shoulder_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_shoulder_horizontal_adduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_shoulder_horizontal_adduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_shoulder_horizontal_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_shoulder_horizontal_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_shoulder_internal_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_shoulder_internal_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_shoulder_external_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_shoulder_external_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_elbow_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_elbow_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_elbow_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_elbow_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_forearm_pronation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_forearm_pronation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_forearm_supination: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_forearm_supination: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_wrist_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_wrist_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_wrist_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_wrist_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_first_hip_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_first_hip_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_second_hip_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_second_hip_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_first_hip_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_first_hip_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_second_hip_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_second_hip_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_hip_adduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_hip_adduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_first_hip_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_first_hip_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_second_hip_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_second_hip_abduction: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_hip_internal_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_hip_internal_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_hip_external_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_hip_external_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_knee_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_knee_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_knee_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_knee_extension: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_ankle_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_ankle_flexion: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_ankle_extension: {
    undefined: nil,
    zero: 0,
    trace: 1.0,
    trace_poor: 1.5,
    poor: 2.0,
    fair: 3.0,
    good: 4.0,
    normal: 5.0,
  }, _prefix: true
  enum left_ankle_extension: {
    undefined: nil,
    zero: 0,
    trace: 1.0,
    trace_poor: 1.5,
    poor: 2.0,
    fair: 3.0,
    good: 4.0,
    normal: 5.0,
  }, _prefix: true
  enum right_ankle_pronation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_ankle_pronation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum right_ankle_supination: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true
  enum left_ankle_supination: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
    normal: 5,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.mmt_scale.#{attr_name}.#{k}"), k] }
  end
end
