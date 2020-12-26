require 'rails_helper'

RSpec.describe "RomScaleDecorator", type: :decorator do
  subject { rom.decorate }

  let!(:rom) do
    create(:rom_scale, right_shoulder_flexion: 60,
                       left_shoulder_abduction: 45,
                       right_elbow_flexion: 60,
                       left_elbow_extension: -20,
                       right_forearm_pronation: 30,
                       left_forearm_supination: 30,
                       right_wrist_flexion: 10,
                       left_wrist_flexion: 10,
                       right_hip_extension: -10,
                       left_hip_adduction: -10,
                       right_knee_flexion: 80,
                       left_knee_extension: -20,
                       right_first_ankle_flexion: -10,
                       left_ankle_supination: 0,)
  end

  it "show limit part" do
    expect(subject.limit_part).to eq [
      ["right_shoulder_flexion", 60],
      ["left_shoulder_abduction", 45],
      ["right_elbow_flexion", 60],
      ["left_elbow_extension", -20],
      ["right_forearm_pronation", 30],
      ["left_forearm_supination", 30],
      ["right_wrist_flexion", 10],
      ["left_wrist_flexion", 10],
      ["right_hip_extension", -10],
      ["left_hip_adduction", -10],
      ["right_knee_flexion", 80],
      ["left_knee_extension", -20],
      ["right_first_ankle_flexion", -10],
      ["left_ankle_supination", 0],
    ]
  end

  it "show right shoulder scale score" do
    expect(subject.right_shoulder_scale_score).to eq(
      "right_shoulder_flexion" => 60,
      "right_shoulder_extension" => nil,
      "right_shoulder_adduction" => nil,
      "right_shoulder_abduction" => nil,
      "right_first_shoulder_internal_rotation" => nil,
      "right_first_shoulder_external_rotation" => nil,
      "right_second_shoulder_internal_rotation" => nil,
      "right_second_shoulder_external_rotation" => nil,
      "right_third_shoulder_internal_rotation" => nil,
      "right_third_shoulder_external_rotation" => nil
    )
  end

  it "show left shoulder scale score" do
    expect(subject.left_shoulder_scale_score).to eq(
      "left_shoulder_flexion" => nil,
      "left_shoulder_extension" => nil,
      "left_shoulder_adduction" => nil,
      "left_shoulder_abduction" => 45,
      "left_first_shoulder_internal_rotation" => nil,
      "left_first_shoulder_external_rotation" => nil,
      "left_second_shoulder_internal_rotation" => nil,
      "left_second_shoulder_external_rotation" => nil,
      "left_third_shoulder_internal_rotation" => nil,
      "left_third_shoulder_external_rotation" => nil
    )
  end

  it "show right elbow scale score" do
    expect(subject.right_elbow_scale_score).to eq(
      "right_elbow_flexion" => 60,
      "right_elbow_extension" => nil
    )
  end

  it "show left elbow scale score" do
    expect(subject.left_elbow_scale_score).to eq(
      "left_elbow_flexion" => nil,
      "left_elbow_extension" => -20
    )
  end

  it "show right forearm scale score" do
    expect(subject.right_forearm_scale_score).to eq(
      "right_forearm_pronation" => 30,
      "right_forearm_supination" => nil
    )
  end

  it "show left forearm scale score" do
    expect(subject.left_forearm_scale_score).to eq(
      "left_forearm_pronation" => nil,
      "left_forearm_supination" => 30
    )
  end

  it "show right wrist scale score" do
    expect(subject.right_wrist_scale_score).to eq(
      "right_wrist_flexion" => 10,
      "right_wrist_extension" => nil,
      "right_wrist_adduction" => nil,
      "right_wrist_abduction" => nil
    )
  end

  it "show left wrist scale score" do
    expect(subject.left_wrist_scale_score).to eq(
      "left_wrist_flexion" => 10,
      "left_wrist_extension" => nil,
      "left_wrist_adduction" => nil,
      "left_wrist_abduction" => nil
    )
  end

  it "show right hip scale score" do
    expect(subject.right_hip_scale_score).to eq(
      "right_hip_flexion" => nil,
      "right_hip_extension" => -10,
      "right_hip_adduction" => nil,
      "right_hip_abduction" => nil,
      "right_hip_internal_rotation" => nil,
      "right_hip_external_rotation" => nil
    )
  end

  it "show left hip scale score" do
    expect(subject.left_hip_scale_score).to eq(
      "left_hip_flexion" => nil,
      "left_hip_extension" => nil,
      "left_hip_adduction" => -10,
      "left_hip_abduction" => nil,
      "left_hip_internal_rotation" => nil,
      "left_hip_external_rotation" => nil
    )
  end

  it "show right knee scale score" do
    expect(subject.right_knee_scale_score).to eq(
      "right_knee_flexion" => 80,
      "right_knee_extension" => nil
    )
  end

  it "show left knee scale score" do
    expect(subject.left_knee_scale_score).to eq(
      "left_knee_flexion" => nil,
      "left_knee_extension" => -20
    )
  end

  it "show right ankle scale score" do
    expect(subject.right_ankle_scale_score).to eq(
      "right_first_ankle_flexion" => -10,
      "right_second_ankle_flexion" => nil,
      "right_ankle_extension" => nil,
      "right_ankle_adduction" => nil,
      "right_ankle_abduction" => nil,
      "right_ankle_pronation" => nil,
      "right_ankle_supination" => nil
    )
  end

  it "show left ankle scale score" do
    expect(subject.left_ankle_scale_score).to eq(
      "left_first_ankle_flexion" => nil,
      "left_second_ankle_flexion" => nil,
      "left_ankle_extension" => nil,
      "left_ankle_adduction" => nil,
      "left_ankle_abduction" => nil,
      "left_ankle_pronation" => nil,
      "left_ankle_supination" => 0
    )
  end
end
