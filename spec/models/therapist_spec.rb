require 'rails_helper'

RSpec.describe Therapist, type: :model do
  it "is valid with uniqueid, firstname, lastname and password" do
    therapist = build(:therapist)
    expect(therapist).to be_valid
  end

  context "invalid when uniqueid" do
    it "is nil" do
      therapist = build(:therapist, unique_id: nil)
      therapist.valid?
      expect(therapist.errors[:unique_id]).to include("を入力してください")
    end
    it "is too short" do
      therapist = build(:therapist, unique_id: "1" * 7)
      therapist.valid?
      expect(therapist.errors[:unique_id]).to include("は8文字で入力してください")
    end
    it "is too long" do
      therapist = build(:therapist, unique_id: "1" * 9)
      therapist.valid?
      expect(therapist.errors[:unique_id]).to include("は8文字で入力してください")
    end
    it "is duplicate" do
      therapist = create(:therapist)
      dup_therapist = build(:therapist, unique_id: therapist.unique_id)
      dup_therapist.valid?
      expect(dup_therapist.errors[:unique_id]).to include("はすでに存在します")
    end
  end

  context "invalid when password" do
    it "is nil" do
      therapist = build(:therapist, password: nil)
      therapist.valid?
      expect(therapist.errors[:password]).to include("を入力してください")
    end
    it "is too short" do
      therapist = build(:therapist, password: "a" * 5, password_confirmation: "a" * 5)
      therapist.valid?
      expect(therapist.errors[:password]).to include("は6文字以上で入力してください")
    end
    it "is too long" do
      therapist = build(:therapist, password: "a" * 129, password_confirmation: "a" * 129)
      therapist.valid?
      expect(therapist.errors[:password]).to include("は128文字以内で入力してください")
    end
    it "is not match" do
      therapist = build(:therapist, password: "foobar", password_confirmation: "barfoo")
      therapist.valid?
      expect(therapist.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end

  context "invalid when first_name" do
    it "is nil" do
      therapist = build(:therapist, first_name: nil)
      therapist.valid?
      expect(therapist.errors[:first_name]).to include("を入力してください")
    end
    it "is blank" do
      therapist = build(:therapist, first_name: "")
      therapist.valid?
      expect(therapist.errors[:first_name]).to include("を入力してください")
    end
    it "is too long" do
      therapist = build(:therapist, first_name: "a" * 11)
      therapist.valid?
      expect(therapist.errors[:first_name]).to include("は10文字以内で入力してください")
    end
  end

  context "invalid when last_name" do
    it "is nil" do
      therapist = build(:therapist, last_name: nil)
      therapist.valid?
      expect(therapist.errors[:last_name]).to include("を入力してください")
    end
    it "is blank" do
      therapist = build(:therapist, last_name: "")
      therapist.valid?
      expect(therapist.errors[:last_name]).to include("を入力してください")
    end
    it "is too long" do
      therapist = build(:therapist, last_name: "a" * 11)
      therapist.valid?
      expect(therapist.errors[:last_name]).to include("は10文字以内で入力してください")
    end
  end
end
