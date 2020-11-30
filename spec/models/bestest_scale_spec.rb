require 'rails_helper'

RSpec.describe BestestScale, type: :model do
  it "is valid with rating and patientid" do
    bestest_scale = build(:bestest_scale)
    expect(bestest_scale).to be_valid
  end

  it "is valid with all columns" do
    bestest_scale = build(:bestest_scale, from_sitting_to_standing: 1,
                                          standing_on_tiptoes: 1,
                                          standing_on_one_leg: 1,
                                          forward_step: 1,
                                          back_step: 1,
                                          lateral_step: 1,
                                          standing: 1,
                                          standing_with_eyes_close: 1,
                                          standing_on_the_slope: 1,
                                          change_walking_speed: 1,
                                          walking_with_rotating_the_head: 1,
                                          pibot_turn: 1,
                                          straddling_obstacles: 1,
                                          tug: 1)
    expect(bestest_scale).to be_valid
  end

  it "is invalid without patientid" do
    bestest_scale = build(:bestest_scale, patient_id: nil)
    bestest_scale.valid?
    expect(bestest_scale.errors[:patient]).to include("を入力してください")
  end
end
