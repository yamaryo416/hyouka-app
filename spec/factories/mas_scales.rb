FactoryBot.define do
  factory :mas_scale do
    elbow_joint { nil }
    wrist_joint { nil }
    knee_joint { nil }
    ankle_joint { nil }
    association :patient
  end
end
