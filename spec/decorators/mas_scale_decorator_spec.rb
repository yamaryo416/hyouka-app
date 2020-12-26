require 'rails_helper'

RSpec.describe "MasScaleDecorator", type: :decorator do
  subject { mas.decorate }

  let!(:mas) do
    create(:mas_scale, right_elbow_joint: "mild_enhancement",
                       left_elbow_joint: "mild_increase",
                       right_wrist_joint: "no_enhancement",
                       left_wrist_joint: "no_enhancement",
                       right_knee_joint: "significant",
                       left_knee_joint: "rigidity",
                       right_ankle_joint: "significant",
                       left_ankle_joint: "rigidity")
  end

  it "show hypertonia part" do
    expect(subject.hypertonia_part).to eq [
      ["right_elbow_joint", "mild_enhancement"],
      ["left_elbow_joint", "mild_increase"],
      ["right_knee_joint", "significant"],
      ["left_knee_joint", "rigidity"],
      ["right_ankle_joint", "significant"],
      ["left_ankle_joint", "rigidity"],
    ]
  end
end
