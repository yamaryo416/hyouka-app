FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "example#{n}"}
    sequence(:user_id) { [*"0".."9"].sample(8).join }
    password { "password" }
    password_confirmation { "password" }

    trait :admin do
      after(:create){|user| user.add_role(:admin) }
    end
  end
end
