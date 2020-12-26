require 'rails_helper'

RSpec.describe "SiasScaleDecorator", type: :decorator do
  subject { sias.decorate }

  let!(:sias) do
    create(:sias_scale, shoulder_motor_function: 1,
                        finger_motor_function: 1.3,
                        hip_motor_function: 2,
                        knee_motor_function: 3,
                        foot_motor_function: 4,
                        upper_limb_muscle_tone: 3.0,
                        lower_limb_muscle_tone: 1.5,
                        upper_limb_tendon_reflex: 2.0,
                        lower_limb_tendon_reflex: 2.0,
                        upper_limb_tactile: 1,
                        lower_limb_tactile: 1,
                        upper_limb_sense_of_position: 1,
                        lower_limb_sense_of_position: 1,
                        shoulder_joint_rom: 2,
                        knee_joint_rom: 1,
                        pain: 3,
                        trunk_verticality: 1,
                        abdominal_mmt: 1,
                        visuospatial_cognition: 2,
                        speech: 1.4,
                        gripstrength: 2,
                        quadriceps_mmt: 3)
  end

  it "show total score" do
    expect(subject.total_score).to eq 39
  end
end
