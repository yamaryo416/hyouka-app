require 'rails_helper'

RSpec.describe "MmtScaleDecorator", type: :decorator do
  subject { mmt.decorate }

  let!(:mmt) do
    create(:mmt_scale, neck_flexion: "fair",
                       right_shoulder_flexion: "fair",
                       right_elbow_flexion: "fair",
                       left_forearm_supination: "fair",
                       left_wrist_flexion: "fair",
                       left_second_hip_extension: "fair",
                       right_knee_flexion: "fair",
                       left_ankle_supination: "fair")
  end

  it "show weak part" do
    expect(subject.weak_part).to eq [
      ["neck_flexion", "fair"],
      ["right_shoulder_flexion", "fair"],
      ["right_elbow_flexion", "fair"],
      ["left_forearm_supination", "fair"],
      ["left_wrist_flexion", "fair"],
      ["left_second_hip_extension", "fair"],
      ["right_knee_flexion", "fair"],
      ["left_ankle_supination", "fair"],
    ]
  end

  it "show neck trunk scale attributes" do
    expect(subject.neck_trunk_scale_attributes).to eq [
      "neck_flexion",
      "neck_extension",
      "trunk_flexion",
      "trunk_extension",
    ]
  end

  it "show right shoulder scale attributes" do
    expect(subject.right_shoulder_scale_attributes).to eq [
      "right_shoulder_flexion",
      "right_shoulder_extension",
      "right_shoulder_abduction",
      "right_shoulder_horizontal_adduction",
      "right_shoulder_horizontal_abduction",
      "right_shoulder_internal_rotation",
      "right_shoulder_external_rotation",
    ]
  end

  it "show left shoulder scale attributes" do
    expect(subject.left_shoulder_scale_attributes).to eq [
      "left_shoulder_flexion",
      "left_shoulder_extension",
      "left_shoulder_abduction",
      "left_shoulder_horizontal_adduction",
      "left_shoulder_horizontal_abduction",
      "left_shoulder_internal_rotation",
      "left_shoulder_external_rotation",
    ]
  end

  it "show right elbow scale attributes" do
    expect(subject.right_elbow_scale_attributes).to eq [
      "right_elbow_flexion",
      "right_elbow_extension",
    ]
  end

  it "show left elbow scale attributes" do
    expect(subject.left_elbow_scale_attributes).to eq [
      "left_elbow_flexion",
      "left_elbow_extension",
    ]
  end

  it "show right forearm scale attributes" do
    expect(subject.right_forearm_scale_attributes).to eq [
      "right_forearm_pronation",
      "right_forearm_supination",
    ]
  end

  it "show left forearm scale attributes" do
    expect(subject.left_forearm_scale_attributes).to eq [
      "left_forearm_pronation",
      "left_forearm_supination",
    ]
  end

  it "show right wrist scale attributes" do
    expect(subject.right_wrist_scale_attributes).to eq [
      "right_wrist_flexion",
      "right_wrist_extension",
    ]
  end

  it "show left wrist scale attributes" do
    expect(subject.left_wrist_scale_attributes).to eq [
      "left_wrist_flexion",
      "left_wrist_extension",
    ]
  end

  it "show right hip scale attributes" do
    expect(subject.right_hip_scale_attributes).to eq [
      "right_first_hip_flexion",
      "right_second_hip_flexion",
      "right_first_hip_extension",
      "right_second_hip_extension",
      "right_hip_adduction",
      "right_first_hip_abduction",
      "right_second_hip_abduction",
      "right_hip_internal_rotation",
      "right_hip_external_rotation",
    ]
  end

  it "show left hip scale attributes" do
    expect(subject.left_hip_scale_attributes).to eq [
      "left_first_hip_flexion",
      "left_second_hip_flexion",
      "left_first_hip_extension",
      "left_second_hip_extension",
      "left_hip_adduction",
      "left_first_hip_abduction",
      "left_second_hip_abduction",
      "left_hip_internal_rotation",
      "left_hip_external_rotation",
    ]
  end

  it "show right knee scale attributes" do
    expect(subject.right_knee_scale_attributes).to eq [
      "right_knee_flexion",
      "right_knee_extension",
    ]
  end

  it "show left knee scale attributes" do
    expect(subject.left_knee_scale_attributes).to eq [
      "left_knee_flexion",
      "left_knee_extension",
    ]
  end

  it "show right ankle scale attributes" do
    expect(subject.right_ankle_scale_attributes).to eq [
      "right_ankle_flexion",
      "right_ankle_extension",
      "right_ankle_pronation",
      "right_ankle_supination",
    ]
  end

  it "show left ankle scale attributes" do
    expect(subject.left_ankle_scale_attributes).to eq [
      "left_ankle_flexion",
      "left_ankle_extension",
      "left_ankle_pronation",
      "left_ankle_supination",
    ]
  end
end
