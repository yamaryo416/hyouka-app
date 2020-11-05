FactoryBot.define do
  factory :patient do
    sequence(:unique_id) { [*"0".."9"].sample(8).join }
    age { nil }
    sex { nil }
    weight { nil }
    height { nil }
    association :therapist
  end
end
