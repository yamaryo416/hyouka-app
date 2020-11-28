FactoryBot.define do
  factory :tactile_scale do
    right_upper_arm { nil }
    left_upper_arm { nil }
    right_forearm { nil }
    left_forearm { nil }
    right_hand { nil }
    left_hand { nil }
    right_thigh { nil }
    left_thigh { nil }
    right_lower_leg { nil }
    left_lower_leg { nil }
    right_rearfoot { nil }
    left_rearfoot { nil }
    right_forefoot { nil }
    left_forefoot { nil }
    association :patient
  end
end
