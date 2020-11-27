FactoryBot.define do
  factory :sias_scale do
    shoulder_motor_function { nil }
    finger_motor_function { nil }
    hip_motor_function { nil }
    knee_motor_function { nil }
    foot_motor_function { nil }
    upper_limb_muscle_tone { nil }
    lower_limb_muscle_tone { nil }
    upper_limb_tendon_reflex { nil }
    lower_limb_tendon_reflex { nil }
    upper_limb_tactile { nil }
    lower_limb_tactile { nil }
    upper_limb_sense_of_position { nil }
    lower_limb_sense_of_position { nil }
    shoulder_joint_rom { nil }
    knee_joint_rom { nil }
    pain { nil }
    trunk_verticality { nil }
    abdominal_mmt { nil }
    visuospatial_cognition { nil }
    speech { nil }
    gripstrength { nil }
    quadriceps_mmt { nil }
    association :patient
  end
end
