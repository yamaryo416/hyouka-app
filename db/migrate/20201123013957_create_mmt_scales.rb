class CreateMmtScales < ActiveRecord::Migration[6.0]
  def change
    create_table :mmt_scales do |t|
      t.integer :neck_flexion
      t.integer :neck_extension
      t.integer :trunk_flexion
      t.integer :trunk_extension
      t.integer :right_shoulder_flexion
      t.integer :left_shoulder_flexion
      t.integer :right_shoulder_extension
      t.integer :left_shoulder_extension
      t.integer :right_shoulder_abduction
      t.integer :left_shoulder_abduction
      t.integer :right_shoulder_horizontal_adduction
      t.integer :left_shoulder_horizontal_adduction
      t.integer :right_shoulder_horizontal_abduction
      t.integer :left_shoulder_horizontal_abduction
      t.integer :right_shoulder_internal_rotation
      t.integer :left_shoulder_internal_rotation
      t.integer :right_shoulder_external_rotation
      t.integer :left_shoulder_external_rotation
      t.integer :right_elbow_flexion
      t.integer :left_elbow_flexion
      t.integer :right_elbow_extension
      t.integer :left_elbow_extension
      t.integer :right_forearm_pronation
      t.integer :left_forearm_pronation
      t.integer :right_forearm_supination
      t.integer :left_forearm_supination
      t.integer :right_wrist_flexion
      t.integer :left_wrist_flexion
      t.integer :right_wrist_extension
      t.integer :left_wrist_extension
      t.integer :right_first_hip_flexion
      t.integer :left_first_hip_flexion
      t.integer :right_second_hip_flexion
      t.integer :left_second_hip_flexion
      t.integer :right_first_hip_extension
      t.integer :left_first_hip_extension
      t.integer :right_second_hip_extension
      t.integer :left_second_hip_extension
      t.integer :right_hip_adduction
      t.integer :left_hip_adduction
      t.integer :right_first_hip_abduction
      t.integer :left_first_hip_abduction
      t.integer :right_second_hip_abduction
      t.integer :left_second_hip_abduction
      t.integer :right_hip_internal_rotation
      t.integer :left_hip_internal_rotation
      t.integer :right_hip_external_rotation
      t.integer :left_hip_external_rotation
      t.integer :right_knee_flexion
      t.integer :left_knee_flexion
      t.integer :right_knee_extension
      t.integer :left_knee_extension
      t.integer :right_ankle_flexion
      t.integer :left_ankle_flexion
      t.float :right_ankle_extension
      t.float :left_ankle_extension
      t.integer :right_ankle_pronation
      t.integer :left_ankle_pronation
      t.integer :right_ankle_supination
      t.integer :left_ankle_supination
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
