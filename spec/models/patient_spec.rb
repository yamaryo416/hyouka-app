require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "is valid with uniqueid and therapisid" do
    patient = build(:patient)
    expect(patient).to be_valid
  end

  it "is valid with uniqueid, therapistid, age, sex, weight, height and therapistid" do
    patient = build(:patient, age: 20, sex: 1, weight: 60.0, height: 170.0)
    expect(patient).to be_valid
  end

  context "invalid when uniqueid" do
    it "is nil" do
      patient = build(:patient, unique_id: nil)
      patient.valid?
      expect(patient.errors[:unique_id]).to include("を入力してください")
    end
    it "is too short" do
      patient = build(:patient, unique_id: "1" * 7)
      patient.valid?
      expect(patient.errors[:unique_id]).to include("は8文字で入力してください")
    end
    it "is too long" do
      patient = build(:patient, unique_id: "1" * 9)
      patient.valid?
      expect(patient.errors[:unique_id]).to include("は8文字で入力してください")
    end
    it "is duplicate" do
      patient = create(:patient)
      dup_patient = build(:patient, unique_id: patient.unique_id)
      dup_patient.valid?
      expect(dup_patient.errors[:unique_id]).to include("はすでに存在します")
    end
  end

  context "invalid when therapistid" do
    it "is nil" do
      patient = build(:patient, therapist_id: nil)
      patient.valid?
      expect(patient.errors[:therapist]).to include("を入力してください")
    end
  end
end
