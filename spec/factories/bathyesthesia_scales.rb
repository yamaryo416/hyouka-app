FactoryBot.define do
  factory :bathyesthesia_scale do
    right_upper_limb { nil }
    left_upper_limb { nil }
    right_lower_limb { nil }
    left_lower_limb { nil }
    right_finger { nil }
    left_finger { nil }
    right_toe { nil }
    left_toe { nil }
    association :patient
  end
end
