FactoryBot.define do
  factory :brs_scale do
    upper_limb { nil }
    finger { nil }
    lower_limb { nil }
    association :patient
  end
end
