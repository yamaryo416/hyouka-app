require 'rails_helper'

RSpec.describe "TactileScaleDecorator", type: :decorator do
  subject { tactile.decorate }

  let!(:tactile) do
    create(:tactile_scale, right_upper_arm: "absent",
                           left_upper_arm: "impaired",
                           right_forearm: "impaired",
                           left_forearm: "absent",
                           right_hand: "normal",
                           left_hand: "absent",
                           right_thigh: "normal",
                           left_thigh: "absent",
                           right_lower_leg: "absent",
                           left_lower_leg: "impaired",
                           right_rearfoot: "normal",
                           left_rearfoot: "absent",
                           right_forefoot: "impaired",
                           left_forefoot: "normal")
  end

  it "show limit part" do
    expect(subject.limit_part).to eq [
      ["right_upper_arm", "absent"],
      ["left_upper_arm", "impaired"],
      ["right_forearm", "impaired"],
      ["left_forearm", "absent"],
      ["left_hand", "absent"],
      ["left_thigh", "absent"],
      ["right_lower_leg", "absent"],
      ["left_lower_leg", "impaired"],
      ["left_rearfoot", "absent"],
      ["right_forefoot", "impaired"],
    ]
  end
end
