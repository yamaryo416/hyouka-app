FactoryBot.define do
  factory :hdsr_scale do
    age { nil }
    year { nil }
    month { nil }
    day { nil }
    day_of_the_week { nil }
    place { nil }
    first_three_word { nil }
    second_three_word { nil }
    third_three_word { nil }
    first_subtraction { nil }
    second_subtraction { nil }
    revese_three_number { nil }
    revese_four_number { nil }
    memory_first_word { nil }
    memory_second_word { nil }
    memory_third_word { nil }
    five_goods { nil }
    vegetables { nil }
    association :patient
  end
end
