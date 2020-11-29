require 'rails_helper'

RSpec.describe NrsScale, type: :model do
  it "is valid with rating and patientid" do
    nrs_scale = build(:nrs_scale)
    expect(nrs_scale).to be_valid
  end

  it "is valid with all columns" do
    nrs_scale = build(:nrs_scale, rating: 1,
                                  status: "resting",
                                  supplement: "痺れる痛み")
    expect(nrs_scale).to be_valid
  end

  it "is invalid without patientid" do
    nrs_scale = build(:nrs_scale, patient_id: nil)
    nrs_scale.valid?
    expect(nrs_scale.errors[:patient]).to include("を入力してください")
  end

  it "is invalid without rating" do
    nrs_scale = build(:nrs_scale, rating: nil)
    nrs_scale.valid?
    expect(nrs_scale.errors[:rating]).to include("を入力してください")
  end
end
