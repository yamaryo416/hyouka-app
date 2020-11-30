FactoryBot.define do
  factory :fact_scale do
    sitting_with_upper_limb_support { nil }
    sitting_with_no_support { nil }
    lower_lateral_dynamic_sitting { nil }
    forward_dynamic_sitting { nil }
    lateral_dynamic_sitting { nil }
    rear_lateral_dynamic_sitting { nil }
    rear_dynamic_sitting { nil }
    lateral_dynamic_sitting_with_trunk_rotation { nil }
    trunk_rotation { nil }
    trunk_extenxion { nil }
    association :patient
  end
end
