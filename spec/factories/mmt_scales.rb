FactoryBot.define do
  factory :mmt_scale do
    neck_flexion { nil }
    neck_extension { nil }
    trunk_flexion { nil }
    trunk_extension { nil }
    right_shoulder_flexion { nil }
    left_shoulder_flexion { nil }
    right_shoulder_extension { nil }
    left_shoulder_extension { nil }
    right_shoulder_abduction { nil }
    left_shoulder_abduction { nil }
    right_shoulder_horizontal_adduction { nil }
    left_shoulder_horizontal_adduction { nil }
    right_shoulder_horizontal_abduction { nil }
    left_shoulder_horizontal_abduction { nil }
    right_shoulder_internal_rotation { nil }
    left_shoulder_internal_rotation { nil }
    right_shoulder_external_rotation { nil }
    left_shoulder_external_rotation { nil }
    right_elbow_flexion { nil }
    left_elbow_flexion { nil }
    right_elbow_extension { nil }
    left_elbow_extension { nil }
    right_forearm_pronation { nil }
    left_forearm_pronation { nil }
    right_forearm_supination { nil }
    left_forearm_supination { nil }
    right_wrist_flexion { nil }
    left_wrist_flexion { nil }
    right_wrist_extension { nil }
    left_wrist_extension { nil }
    right_first_hip_flexion { nil }
    left_first_hip_flexion { nil }
    right_second_hip_flexion { nil }
    left_second_hip_flexion { nil }
    right_first_hip_extension { nil }
    left_first_hip_extension { nil }
    right_second_hip_extension { nil }
    left_second_hip_extension { nil }
    right_hip_adduction { nil }
    left_hip_adduction { nil }
    right_first_hip_abduction { nil }
    left_first_hip_abduction { nil }
    right_second_hip_abduction { nil }
    left_second_hip_abduction { nil }
    right_hip_internal_rotation { nil }
    left_hip_internal_rotation { nil }
    right_hip_external_rotation { nil }
    left_hip_external_rotation { nil }
    right_knee_flexion { nil }
    left_knee_flexion { nil }
    right_knee_extension { nil }
    left_knee_extension { nil }
    right_ankle_flexion { nil }
    left_ankle_flexion { nil }
    right_ankle_extension { nil }
    left_ankle_extension { nil }
    right_ankle_pronation { nil }
    left_ankle_pronation { nil }
    right_ankle_supination { nil }
    left_ankle_supination { nil }

    association :patient
  end
end
