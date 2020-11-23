class RomScale < ApplicationRecord
  belongs_to :patient
  with_options inclusion: -180..180, allow_nil: true do
    validates :right_shoulder_flexion
    validates :left_shoulder_flexion
    validates :right_shoulder_extension
    validates :left_shoulder_extension
    validates :right_shoulder_adduction
    validates :left_shoulder_adduction
    validates :right_shoulder_abduction
    validates :left_shoulder_abduction
    validates :right_first_shoulder_internal_rotation
    validates :left_first_shoulder_internal_rotation
    validates :right_first_shoulder_external_rotation
    validates :left_first_shoulder_external_rotation
    validates :right_second_shoulder_internal_rotation
    validates :left_second_shoulder_internal_rotation
    validates :right_second_shoulder_external_rotation
    validates :left_second_shoulder_external_rotation
    validates :right_third_shoulder_internal_rotation
    validates :left_third_shoulder_internal_rotation
    validates :right_third_shoulder_external_rotation
    validates :left_third_shoulder_external_rotation
    validates :right_elbow_flexion
    validates :left_elbow_flexion
    validates :right_elbow_extension
    validates :left_elbow_extension
    validates :right_forearm_pronation
    validates :left_forearm_pronation
    validates :right_forearm_supination
    validates :left_forearm_supination
    validates :right_wrist_flexion
    validates :left_wrist_flexion
    validates :right_wrist_extension
    validates :left_wrist_extension
    validates :right_wrist_adduction
    validates :left_wrist_adduction
    validates :right_wrist_abduction
    validates :left_wrist_abduction
    validates :right_hip_flexion
    validates :left_hip_flexion
    validates :right_hip_extension
    validates :left_hip_extension
    validates :right_hip_adduction
    validates :left_hip_adduction
    validates :right_hip_abduction
    validates :left_hip_abduction
    validates :right_hip_internal_rotation
    validates :left_hip_internal_rotation
    validates :right_hip_external_rotation
    validates :left_hip_external_rotation
    validates :right_knee_flexion
    validates :left_knee_flexion
    validates :right_knee_extension
    validates :left_knee_extension
    validates :right_first_ankle_flexion
    validates :left_first_ankle_flexion
    validates :right_second_ankle_flexion
    validates :left_second_ankle_flexion
    validates :right_ankle_extension
    validates :left_ankle_extension
    validates :right_ankle_adduction
    validates :left_ankle_adduction
    validates :right_ankle_abduction
    validates :left_ankle_abduction
    validates :right_ankle_pronation
    validates :left_ankle_pronation
    validates :right_ankle_supination
    validates :left_ankle_supination
  end

  def each_score
    each_score = {}
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name)
        next
      else
        each_score.store(attr_name, value)
      end
    end
    each_score
  end

  def direction_part_each_score(direction, part)
    direction_part_each_score = {}
    each_score.each do |attr_name, value|
      if attr_name.include?(direction) && attr_name.include?(part)
        value = "未入力" if value.nil?
        direction_part_each_score.store(attr_name, value)
      end
    end
    direction_part_each_score
  end

  def right_shoulder_each_score
    direction_part_each_score("right", "shoulder")
  end

  def left_shoulder_each_score
    direction_part_each_score("left", "shoulder")
  end

  def right_elbow_each_score
    direction_part_each_score("right", "elbow")
  end

  def left_elbow_each_score
    direction_part_each_score("left", "elbow")
  end

  def right_forearm_each_score
    direction_part_each_score("right", "forearm")
  end

  def left_forearm_each_score
    direction_part_each_score("left", "forearm")
  end

  def right_wrist_each_score
    direction_part_each_score("right", "wrist")
  end

  def left_wrist_each_score
    direction_part_each_score("left", "wrist")
  end

  def right_hip_each_score
    direction_part_each_score("right", "hip")
  end

  def left_hip_each_score
    direction_part_each_score("left", "hip")
  end

  def right_knee_each_score
    direction_part_each_score("right", "knee")
  end

  def left_knee_each_score
    direction_part_each_score("left", "knee")
  end

  def right_ankle_each_score
    direction_part_each_score("right", "ankle")
  end

  def left_ankle_each_score
    direction_part_each_score("left", "ankle")
  end
end
