FactoryBot.define do
  factory :patient do
    first_name { "example" }
    last_name { "example" }
    age { nil }
    sex { nil }
    weight { nil }
    height { nil }
    association :therapist
  end
end
