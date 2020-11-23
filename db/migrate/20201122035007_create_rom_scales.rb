class CreateRomScales < ActiveRecord::Migration[6.0]
  def change
    create_table :rom_scales do |t|
      t.integer :right_shoulder_flexion
      t.integer :left_shoulder_flexion
      t.integer :right_shoulder_extension
      t.integer :left_shoulder_extension
      t.integer :right_shoulder_adduction
      t.integer :left_shoulder_adduction
      t.integer :right_shoulder_abduction
      t.integer :left_shoulder_abduction
      t.integer :right_first_shoulder_internal_rotation
      t.integer :left_first_shoulder_internal_rotation
      t.integer :right_first_shoulder_external_rotation
      t.integer :left_first_shoulder_external_rotation
      t.integer :right_second_shoulder_internal_rotation
      t.integer :left_second_shoulder_internal_rotation
      t.integer :right_second_shoulder_external_rotation
      t.integer :left_second_shoulder_external_rotation
      t.integer :right_third_shoulder_internal_rotation
      t.integer :left_third_shoulder_internal_rotation
      t.integer :right_third_shoulder_external_rotation
      t.integer :left_third_shoulder_external_rotation
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
      t.integer :right_wrist_adduction
      t.integer :left_wrist_adduction
      t.integer :right_wrist_abduction
      t.integer :left_wrist_abduction
      t.integer :right_hip_flexion
      t.integer :left_hip_flexion
      t.integer :right_hip_extension
      t.integer :left_hip_extension
      t.integer :right_hip_adduction
      t.integer :left_hip_adduction
      t.integer :right_hip_abduction
      t.integer :left_hip_abduction
      t.integer :right_hip_internal_rotation
      t.integer :left_hip_internal_rotation
      t.integer :right_hip_external_rotation
      t.integer :left_hip_external_rotation
      t.integer :right_knee_flexion
      t.integer :left_knee_flexion
      t.integer :right_knee_extension
      t.integer :left_knee_extension
      t.integer :right_first_ankle_flexion
      t.integer :left_first_ankle_flexion
      t.integer :right_second_ankle_flexion
      t.integer :left_second_ankle_flexion
      t.integer :right_ankle_extension
      t.integer :left_ankle_extension
      t.integer :right_ankle_adduction
      t.integer :left_ankle_adduction
      t.integer :right_ankle_abduction
      t.integer :left_ankle_abduction
      t.integer :right_ankle_pronation
      t.integer :left_ankle_pronation
      t.integer :right_ankle_supination
      t.integer :left_ankle_supination
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
