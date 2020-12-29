require 'rails_helper'

RSpec.describe "BathyesthesiaScaleDecorator", type: :decorator do
  subject { bathyesthesia.decorate }

  let!(:bathyesthesia) do
    create(:bathyesthesia_scale, right_upper_limb: "normal",
                                 left_upper_limb: "normal",
                                 right_lower_limb: "impaired",
                                 left_lower_limb: "impaired",
                                 right_finger: "impaired",
                                 left_finger: "normal",
                                 right_toe: "normal",
                                 left_toe: "impaired")
  end

  it "show limit part" do
    expect(subject.limit_part).to eq [
      ["right_lower_limb", "impaired"],
      ["left_lower_limb", "impaired"],
      ["right_finger", "impaired"],
      ["left_toe", "impaired"],
    ]
  end

  it "show right position sense scale attributes" do
    expect(subject.right_position_sense_scale_attributes).to eq [
      "right_upper_limb",
      "right_lower_limb",
    ]
  end

  it "show left position sense scale attributes" do
    expect(subject.left_position_sense_scale_attributes).to eq [
      "left_upper_limb",
      "left_lower_limb",
    ]
  end

  it "show right motor sense scale attributes" do
    expect(subject.right_motor_sense_scale_attributes).to eq [
      "right_finger",
      "right_toe",
    ]
  end

  it "show left motor sense scale attributes" do
    expect(subject.left_motor_sense_scale_attributes).to eq [
      "left_finger",
      "left_toe",
    ]
  end
end
