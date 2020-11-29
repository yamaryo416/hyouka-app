FactoryBot.define do
  factory :nrs_scale do
    rating { 1 }
    status { nil }
    supplement { nil }
    association :patient
  end
end
