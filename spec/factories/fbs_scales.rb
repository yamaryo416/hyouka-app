FactoryBot.define do
  factory :fbs_scale do
    stand_up { nil }
    standing { nil }
    sitting { nil }
    sit_down { nil }
    transfer { nil }
    standing_with_eyes_close { nil }
    standing_with_leg_close { nil }
    reach_forward { nil }
    pickup_from_floor { nil }
    turn_around { nil }
    one_rotation { nil }
    stepup_and_down { nil }
    tandem_standing { nil }
    standing_with_one_leg { nil }
    association :patient
  end
end
