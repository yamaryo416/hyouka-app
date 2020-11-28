require 'rails_helper'

RSpec.describe TactileScale, type: :model do
  it "is valid with patientid" do
    tactile_scale = build(:tactile_scale)
    expect(tactile_scale).to be_valid
  end

  it "is valid with all columns" do
    tactile_scale = build(:tactile_scale, right_upper_arm: 1,
                                          left_upper_arm: 1,
                                          right_forearm: 1,
                                          left_forearm: 1,
                                          right_hand: 1,
                                          left_hand: 1,
                                          right_thigh: 1,
                                          left_thigh: 1,
                                          right_lower_leg: 1,
                                          left_lower_leg: 1,
                                          right_rearfoot: 1,
                                          left_rearfoot: 1,
                                          right_forefoot: 1,
                                          left_forefoot: 1)
    expect(tactile_scale).to be_valid
  end

  it "is invalid without patientid" do
    tactile_scale = build(:tactile_scale, patient_id: nil)
    tactile_scale.valid?
    expect(tactile_scale.errors[:patient]).to include("を入力してください")
  end
end
