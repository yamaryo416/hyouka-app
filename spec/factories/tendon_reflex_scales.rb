FactoryBot.define do
  factory :tendon_reflex_scale do
    jaw { nil }
    abdominal { nil }
    right_pectoral { nil }
    left_pectoral { nil }
    right_biceps { nil }
    left_biceps { nil }
    right_triceps { nil }
    left_triceps { nil }
    right_brachioradialis { nil }
    left_brachioradialis { nil }
    right_pronator { nil }
    left_pronator { nil }
    right_patellar_tendon { nil }
    left_patellar_tendon { nil }
    right_achilles_tendon { nil }
    left_achilles_tendon { nil }
    association :patient
  end
end
