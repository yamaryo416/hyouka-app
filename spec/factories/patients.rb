FactoryBot.define do
  factory :patient do
    patient_id { "MyString" }
    age { 1 }
    height { 1.5 }
    weight { 1.5 }
    user { nil }
  end
end
