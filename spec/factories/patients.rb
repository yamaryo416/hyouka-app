FactoryBot.define do
  factory :patient do
    unique_id { "MyString" }
    age { 1 }
    sex { 1 }
    weight { 1.5 }
    height { 1.5 }
    therapist { nil }
  end
end
