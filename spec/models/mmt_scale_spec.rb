require 'rails_helper'

RSpec.describe MmtScale, type: :model do
  it "is valid with patientid" do
    mmt_scale = build(:mmt_scale)
    expect(mmt_scale).to be_valid
  end

  it "is valid with all columns" do
    mmt_scale = build(:mmt_scale, neck_flexion: 1,
                                  neck_extension: 1,
                                  trunk_flexion: 1,
                                  trunk_extension: 1,
                                  right_shoulder_flexion: 1,
                                  left_shoulder_flexion: 1,
                                  right_shoulder_extension: 1,
                                  left_shoulder_extension: 1,
                                  right_shoulder_abduction: 1,
                                  left_shoulder_abduction: 1,
                                  right_shoulder_horizontal_adduction: 1,
                                  left_shoulder_horizontal_adduction: 1,
                                  right_shoulder_horizontal_abduction: 1,
                                  left_shoulder_horizontal_abduction: 1,
                                  right_shoulder_internal_rotation: 1,
                                  left_shoulder_internal_rotation: 1,
                                  right_shoulder_external_rotation: 1,
                                  left_shoulder_external_rotation: 1,
                                  right_elbow_flexion: 1,
                                  left_elbow_flexion: 1,
                                  right_elbow_extension: 1,
                                  left_elbow_extension: 1,
                                  right_forearm_pronation: 1,
                                  left_forearm_pronation: 1,
                                  right_forearm_supination: 1,
                                  left_forearm_supination: 1,
                                  right_wrist_flexion: 1,
                                  left_wrist_flexion: 1,
                                  right_wrist_extension: 1,
                                  left_wrist_extension: 1,
                                  right_first_hip_flexion: 1,
                                  left_first_hip_flexion: 1,
                                  right_second_hip_flexion: 1,
                                  left_second_hip_flexion: 1,
                                  right_first_hip_extension: 1,
                                  left_first_hip_extension: 1,
                                  right_second_hip_extension: 1,
                                  left_second_hip_extension: 1,
                                  right_hip_adduction: 1,
                                  left_hip_adduction: 1,
                                  right_first_hip_abduction: 1,
                                  left_first_hip_abduction: 1,
                                  right_second_hip_abduction: 1,
                                  left_second_hip_abduction: 1,
                                  right_hip_internal_rotation: 1,
                                  left_hip_internal_rotation: 1,
                                  right_hip_external_rotation: 1,
                                  left_hip_external_rotation: 1,
                                  right_knee_flexion: 1,
                                  left_knee_flexion: 1,
                                  right_knee_extension: 1,
                                  left_knee_extension: 1,
                                  right_ankle_flexion: 1,
                                  left_ankle_flexion: 1,
                                  right_ankle_extension: 1.5,
                                  left_ankle_extension: 1.5,
                                  right_ankle_pronation: 1,
                                  left_ankle_pronation: 1,
                                  right_ankle_supination: 1,
                                  left_ankle_supination: 1)
    expect(mmt_scale).to be_valid
  end

  it "is invalid without patientid" do
    mmt_scale = build(:mmt_scale, patient_id: nil)
    mmt_scale.valid?
    expect(mmt_scale.errors[:patient]).to include("を入力してください")
  end
end
