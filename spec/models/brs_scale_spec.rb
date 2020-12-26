require 'rails_helper'

RSpec.describe BrsScale, type: :model do
  it "is valid with patientid" do
    brs_scale = build(:brs_scale)
    expect(brs_scale).to be_valid
  end

  it "is valid with all columns" do
    brs_scale = build(:brs_scale, upper_limb: 1,
                                  finger: 3,
                                  lower_limb: 5)
    expect(brs_scale).to be_valid
  end

  it "is invalid without patientid" do
    brs_scale = build(:brs_scale, patient_id: nil)
    brs_scale.valid?
    expect(brs_scale.errors[:patient]).to include("を入力してください")
  end
end
