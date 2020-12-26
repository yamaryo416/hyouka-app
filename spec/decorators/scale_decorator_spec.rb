require 'rails_helper'

RSpec.describe "ScaleDecorator", type: :decorator do
  let!(:fact) do
    create(:fact_scale, sitting_with_upper_limb_support: "impossible",
                        sitting_with_no_support: "impossible",
                        lower_lateral_dynamic_sitting: "possible",
                        forward_dynamic_sitting: "possible",
                        lateral_dynamic_sitting: "both_sides",
                        rear_lateral_dynamic_sitting: "one_side",
                        rear_dynamic_sitting: "undefined",
                        lateral_dynamic_sitting_with_trunk_rotation: "undefined",
                        trunk_rotation: "undefined",
                        trunk_extenxion: "undefined")
  end
  let!(:mas) { create(:mas_scale) }

  it "show total score" do
    expect(fact.decorate.total_score).to eq 6
  end

  it "show undefined count" do
    expect(fact.decorate.undefined_count).to eq 4
  end

  it "show right scale attributes" do
    expect(mas.decorate.right_scale_attributes).to eq [
      "right_elbow_joint",
      "right_wrist_joint",
      "right_knee_joint",
      "right_ankle_joint",
    ]
  end

  it "show left scale attributes" do
    expect(mas.decorate.left_scale_attributes).to eq [
      "left_elbow_joint",
      "left_wrist_joint",
      "left_knee_joint",
      "left_ankle_joint",
    ]
  end
end
