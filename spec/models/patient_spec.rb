require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "is valid with firstname, lastname and therapisid" do
    patient = build(:patient)
    expect(patient).to be_valid
  end

  it "is valid with uniqueid, therapistid, age, sex, weight, height and therapistid" do
    patient = build(:patient, first_name: "hoge",
                              last_name: "hoge",
                              age: 20,
                              sex: 1,
                              weight: 60.0,
                              height: 170.0)
    expect(patient).to be_valid
  end

  context "invalid when first_name" do
    it "is nil" do
      patient = build(:patient, first_name: nil)
      patient.valid?
      expect(patient.errors[:first_name]).to include("を入力してください")
    end
    it "is blank" do
      patient = build(:patient, first_name: "")
      patient.valid?
      expect(patient.errors[:first_name]).to include("を入力してください")
    end
    it "is too long" do
      patient = build(:patient, first_name: "a" * 11)
      patient.valid?
      expect(patient.errors[:first_name]).to include("は10文字以内で入力してください")
    end
  end

  context "invalid when last_name" do
    it "is nil" do
      patient = build(:patient, last_name: nil)
      patient.valid?
      expect(patient.errors[:last_name]).to include("を入力してください")
    end
    it "is blank" do
      patient = build(:patient, last_name: "")
      patient.valid?
      expect(patient.errors[:last_name]).to include("を入力してください")
    end
    it "is too long" do
      patient = build(:patient, last_name: "a" * 11)
      patient.valid?
      expect(patient.errors[:last_name]).to include("は10文字以内で入力してください")
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
