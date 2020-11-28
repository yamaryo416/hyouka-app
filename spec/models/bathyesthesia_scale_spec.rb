require 'rails_helper'

RSpec.describe BathyesthesiaScale, type: :model do
  it "is valid with patientid" do
    bathyesthesia_scale = build(:bathyesthesia_scale)
    expect(bathyesthesia_scale).to be_valid
  end

  it "is valid with all columns" do
    bathyesthesia_scale = build(:bathyesthesia_scale, right_upper_limb: 1,
                                                      left_upper_limb: 1,
                                                      right_lower_limb: 1,
                                                      left_lower_limb: 1,
                                                      right_finger: 1,
                                                      left_finger: 1,
                                                      right_toe: 1,
                                                      left_toe: 1)
    expect(bathyesthesia_scale).to be_valid
  end

  it "is invalid without patientid" do
    bathyesthesia_scale = build(:bathyesthesia_scale, patient_id: nil)
    bathyesthesia_scale.valid?
    expect(bathyesthesia_scale.errors[:patient]).to include("を入力してください")
  end
end
