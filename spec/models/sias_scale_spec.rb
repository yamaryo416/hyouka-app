require 'rails_helper'

RSpec.describe SiasScale, type: :model do
  it "is valid with firstname lastname and patientid" do
    sias_scale = build(:sias_scale)
    expect(sias_scale).to be_valid
  end

  it "is valid with all columns" do
    sias_scale = build(:sias_scale, shoulder_motor_function: 1,
                                    finger_motor_function: 1.0,
                                    hip_motor_function: 1,
                                    knee_motor_function: 1,
                                    foot_motor_function: 1,
                                    upper_limb_muscle_tone: 1.0,
                                    lower_limb_muscle_tone: 1.0,
                                    upper_limb_tendon_reflex: 1.0,
                                    lower_limb_tendon_reflex: 1.0,
                                    upper_limb_tactile: 1,
                                    lower_limb_tactile: 1,
                                    upper_limb_sense_of_position: 1,
                                    lower_limb_sense_of_position: 1,
                                    shoulder_joint_rom: 1,
                                    knee_joint_rom: 1,
                                    pain: 1,
                                    trunk_verticality: 1,
                                    abdominal_mmt: 1,
                                    visuospatial_cognition: 1,
                                    speech: 1.0,
                                    gripstrength: 1,
                                    quadriceps_mmt: 1)
    expect(sias_scale).to be_valid
  end

  it "is invalid without patientid" do
    sias_scale = build(:sias_scale, patient_id: nil)
    sias_scale.valid?
    expect(sias_scale.errors[:patient]).to include("を入力してください")
  end
end
