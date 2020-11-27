require 'rails_helper'

RSpec.describe FbsScale, type: :model do
  it "is valid with patientid" do
    fbs_scale = build(:fbs_scale)
    expect(fbs_scale).to be_valid
  end

  it "is valid with all columns" do
    fbs_scale = build(:fbs_scale, stand_up: 1,
                                  standing: 1,
                                  sitting: 1,
                                  sit_down: 1,
                                  transfer: 1,
                                  standing_with_eyes_close: 1,
                                  standing_with_leg_close: 1,
                                  reach_forward: 1,
                                  pickup_from_floor: 1,
                                  turn_around: 1,
                                  one_rotation: 1,
                                  stepup_and_down: 1,
                                  tandem_standing: 1,
                                  standing_with_one_leg: 1)
    expect(fbs_scale).to be_valid
  end

  it "is invalid without patientid" do
    fbs_scale = build(:fbs_scale, patient_id: nil)
    fbs_scale.valid?
    expect(fbs_scale.errors[:patient]).to include("を入力してください")
  end
end
