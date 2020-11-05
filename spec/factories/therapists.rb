FactoryBot.define do
  factory :therapist do
    sequence(:name) { |n| "example#{n}" }
    sequence(:unique_id) { [*"0".."9"].sample(8).join }
    password { "password" }
    password_confirmation { "password" }

    trait :admin do
      after(:create) { |therapist| therapist.add_role(:admin) }
    end
  end
end
