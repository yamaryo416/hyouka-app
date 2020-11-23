require 'rails_helper'

RSpec.describe RomScale, type: :model do
  it "is valid with patientid" do
    rom_scale = build(:rom_scale)
    expect(rom_scale).to be_valid
  end

  it "is valid with all columns" do
    rom_scale = build(:rom_scale, right_shoulder_flexion: 90,
                                  left_shoulder_flexion: 90,
                                  right_shoulder_extension: 90,
                                  left_shoulder_extension: 90,
                                  right_shoulder_adduction: 90,
                                  left_shoulder_adduction: 90,
                                  right_shoulder_abduction: 90,
                                  left_shoulder_abduction: 90,
                                  right_first_shoulder_internal_rotation: 90,
                                  left_first_shoulder_internal_rotation: 90,
                                  right_first_shoulder_external_rotation: 90,
                                  left_first_shoulder_external_rotation: 90,
                                  right_second_shoulder_internal_rotation: 90,
                                  left_second_shoulder_internal_rotation: 90,
                                  right_second_shoulder_external_rotation: 90,
                                  left_second_shoulder_external_rotation: 90,
                                  right_third_shoulder_internal_rotation: 90,
                                  left_third_shoulder_internal_rotation: 90,
                                  right_third_shoulder_external_rotation: 90,
                                  left_third_shoulder_external_rotation: 90,
                                  right_elbow_flexion: 90,
                                  left_elbow_flexion: 90,
                                  right_elbow_extension: 90,
                                  left_elbow_extension: 90,
                                  right_forearm_pronation: 90,
                                  left_forearm_pronation: 90,
                                  right_forearm_supination: 90,
                                  left_forearm_supination: 90,
                                  right_wrist_flexion: 90,
                                  left_wrist_flexion: 90,
                                  right_wrist_extension: 90,
                                  left_wrist_extension: 90,
                                  right_wrist_adduction: 90,
                                  left_wrist_adduction: 90,
                                  right_wrist_abduction: 90,
                                  left_wrist_abduction: 90,
                                  right_hip_flexion: 90,
                                  left_hip_flexion: 90,
                                  right_hip_extension: 90,
                                  left_hip_extension: 90,
                                  right_hip_adduction: 90,
                                  left_hip_adduction: 90,
                                  right_hip_abduction: 90,
                                  left_hip_abduction: 90,
                                  right_hip_internal_rotation: 90,
                                  left_hip_internal_rotation: 90,
                                  right_hip_external_rotation: 90,
                                  left_hip_external_rotation: 90,
                                  right_knee_flexion: 90,
                                  left_knee_flexion: 90,
                                  right_knee_extension: 90,
                                  left_knee_extension: 90,
                                  right_first_ankle_flexion: 90,
                                  left_first_ankle_flexion: 90,
                                  right_second_ankle_flexion: 90,
                                  left_second_ankle_flexion: 90,
                                  right_ankle_extension: 90,
                                  left_ankle_extension: 90,
                                  right_ankle_adduction: 90,
                                  left_ankle_adduction: 90,
                                  right_ankle_abduction: 90,
                                  left_ankle_abduction: 90,
                                  right_ankle_pronation: 90,
                                  left_ankle_pronation: 90,
                                  right_ankle_supination: 90,
                                  left_ankle_supination: 90)
    expect(rom_scale).to be_valid
  end

  it "is invalid without patientid" do
    rom_scale = build(:rom_scale, patient_id: nil)
    rom_scale.valid?
    expect(rom_scale.errors[:patient]).to include("を入力してください")
  end
end
