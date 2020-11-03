require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with userid, name, and password" do
    user = build(:user)
    expect(user).to be_valid
  end

  context "userid is invalid" do
    it "is nil" do
      user = build(:user, user_id: nil)
      user.valid?
      expect(user.errors[:user_id]).to include("を入力してください")
    end
    it "is too short" do
      user = build(:user, user_id: "1"*7)
      user.valid?
      expect(user.errors[:user_id]).to include("は8文字で入力してください")
    end
    it "is too long" do
      user = build(:user, user_id: "1"*9)
      user.valid?
      expect(user.errors[:user_id]).to include("は8文字で入力してください")
    end
    it "is duplicate" do
      user = create(:user)
      dup_user = build(:user, user_id: user.user_id)
      dup_user.valid?
      expect(dup_user.errors[:user_id]).to include("はすでに存在します")
    end
  end

  context "password is invalid" do
    it "is nil" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "is too short" do
      user = build(:user, password: "a"*5, password_confirmation: "a"*5)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
    it "is too long" do
      user = build(:user, password: "a"*129, password_confirmation: "a"*129)
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end
    it "is not match" do
      user = build(:user, password: "foobar", password_confirmation: "barfoo")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end

  it "is invalid without name" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
end
