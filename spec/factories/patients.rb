FactoryBot.define do
  factory :patient do
    first_name { "example" }
    last_name { "example" }
    age { nil }
    sex { nil }
    height { nil }
    weight { nil }
    association :therapist
  end
end
