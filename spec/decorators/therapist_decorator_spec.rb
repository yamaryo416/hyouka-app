require 'rails_helper'

RSpec.describe "TherapistDecorator", type: :decorator do
  subject { therapist.decorate }

  let!(:therapist) { create(:therapist, first_name: "鈴木", last_name: "太郎") }

  it "show full name" do
    expect(subject.full_name).to eq "鈴木 太郎"
  end
end
