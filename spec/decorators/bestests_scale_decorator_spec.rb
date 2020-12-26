require 'rails_helper'

RSpec.describe "BestestScaleDecorator", type: :decorator do
  subject { bestest.decorate }

  let!(:bestest) do
    create(:bestest_scale, from_sitting_to_standing: "zero",
                           standing_on_tiptoes: "one",
                           standing_on_one_leg: "one",
                           forward_step: "zero",
                           back_step: "one",
                           lateral_step: "two",
                           standing: "one",
                           standing_with_eyes_close: "zero",
                           standing_on_the_slope: "zero",
                           change_walking_speed: "two",
                           walking_with_rotating_the_head: "two",
                           pibot_turn: "one",
                           straddling_obstacles: "two",
                           tug: "one")
  end

  it "show apa score" do
    expect(subject.apa_score).to eq 2
  end

  it "show cpa score" do
    expect(subject.cpa_score).to eq 3
  end

  it "show sensory function score" do
    expect(subject.sensory_function_score).to eq 1
  end

  it "show dynamic walking score" do
    expect(subject.dynamic_walking_score).to eq 8
  end

  it "show total score" do
    expect(subject.total_score).to eq 14
  end
end
