require 'rails_helper'

RSpec.describe MasScale, type: :model do
  it "is valid with patientid" do
    mas_scale = build(:mas_scale)
    expect(mas_scale).to be_valid
  end

  it "is valid with all columns" do
    mas_scale = build(:mas_scale, right_elbow_joint: 1,
                                  left_elbow_joint: 1,
                                  right_wrist_joint: 1,
                                  left_wrist_joint: 1,
                                  right_knee_joint: 1,
                                  left_knee_joint: 1,
                                  right_ankle_joint: 1,
                                  left_ankle_joint: 1)
    expect(mas_scale).to be_valid
  end

  it "is invalid without patientid" do
    mas_scale = build(:mas_scale, patient_id: nil)
    mas_scale.valid?
    expect(mas_scale.errors[:patient]).to include("を入力してください")
  end
end
