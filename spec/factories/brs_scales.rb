FactoryBot.define do
  factory :brs_scale do
    upper_limbs { nil }
    finger { nil }
    lower_limbs { nil }
    association :patient
  end
end
