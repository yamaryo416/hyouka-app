FactoryBot.define do
  factory :bestest_scale do
    from_sitting_to_standing { nil }
    standing_on_tiptoes { nil }
    standing_on_one_leg { nil }
    forward_step { nil }
    back_step { nil }
    lateral_step { nil }
    standing { nil }
    standing_with_eyes_close { nil }
    standing_on_the_slope { nil }
    change_walking_speed { nil }
    walking_with_rotating_the_head { nil }
    pibot_turn { nil }
    straddling_obstacles { nil }
    tug { nil }
    association :patient
  end
end
