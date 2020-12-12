FactoryBot.define do
  factory :mas_scale do
    right_elbow_joint { nil }
    left_elbow_joint { nil }
    right_wrist_joint { nil }
    left_wrist_joint { nil }
    right_knee_joint { nil }
    left_knee_joint { nil }
    right_ankle_joint { nil }
    left_ankle_joint { nil }
    association :patient
  end
end
