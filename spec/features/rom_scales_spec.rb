require "rails_helper"

RSpec.feature "RomScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_rom) do
    create(:rom_scale, right_shoulder_flexion: 90,
                       left_shoulder_flexion: 60,
                       right_shoulder_extension: 0,
                       right_forearm_supination: 20,
                       right_wrist_extension: 10,
                       patient: second_patient)
  end
  let!(:oldest_third_patient_rom) do
    create(:rom_scale, left_wrist_flexion: 10,
                       right_wrist_adduction: 0,
                       patient: third_patient)
  end
  let!(:third_patient_roms) do
    create_list(:rom_scale, 5, left_hip_extension: 5, patient: third_patient)
  end
  let!(:latest_third_patient_rom) do
    create(:rom_scale, right_hip_adduction: -5,
                       right_hip_internal_rotation: 0,
                       right_hip_external_rotation: 5,
                       left_knee_flexion: 20,
                       right_knee_extension: -30,
                       patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient rom" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "ROM"
    expect(page).not_to have_selector ".defined-scale", text: "ROM"
    click_on "ROM"
    expect(page).to have_current_path new_patient_rom_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "ROM作成"
    fill_in "right_shoulder_flexion_form", with: 90
    fill_in "left_shoulder_flexion_form", with: 45
    fill_in "right_shoulder_extension_form", with: 20
    click_on "保存する"
    expect(page).to have_current_path patient_rom_scales_path(first_patient)
    expect(page).to have_selector ".rom0-limit-part-count",
                                  text: "3箇所に可動域制限があります。"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient rom" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "ROM"
    expect(page).not_to have_selector ".undefined-scale", text: "ROM"
    click_on "ROM"
    expect(page).to have_current_path patient_rom_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_rom_scale_path(
      second_patient, second_patient_rom
    )
    expect(page).to have_selector ".page-title", text: "ROM"
    expect(page).to have_selector ".limit-part-detail",
                                  text: "右肩関節屈曲 左肩関節屈曲 右肩関節伸展 右前腕回外 右手関節背屈"
    expect(page).to have_selector ".right_shoulder_flexion_score", text: "90°"
    expect(page).to have_selector ".left_shoulder_flexion_score", text: "60°"
    expect(page).to have_selector ".right_shoulder_extension_score", text: "0°"
    expect(page).to have_selector ".right_forearm_supination_score", text: "20°"
    expect(page).to have_selector ".right_wrist_extension_score", text: "10°"
    expect(page).to have_link "ROM一覧"
    expect(page).to have_link "ROMを編集"
    expect(page).to have_link "ROMを削除"
  end

  scenario "index patient rom" do
    visit patient_rom_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "ROM一覧"
    expect(page).to have_selector ".rom0-limit-part-count",
                                  text: "5箇所に可動域制限があります。"
    expect(page).to have_selector ".rom6-limit-part-count",
                                  text: "2箇所に可動域制限があります。"
  end

  scenario "edit patient rom" do
    visit patient_rom_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_rom_scale_path(
      second_patient, second_patient_rom
    )
    expect(page).to have_selector ".page-title", text: "ROM編集"
    fill_in "right_elbow_flexion_form", with: 0
    fill_in "right_wrist_flexion_form", with: 0
    fill_in "right_hip_flexion_form", with: 0
    click_on "保存する"
    expect(page).to have_current_path patient_rom_scales_path second_patient
    expect(page).to have_selector ".rom0-limit-part-count",
                                  text: "8箇所に可動域制限があります。"
    click_on "詳細"
    expect(page).to have_selector ".right_elbow_flexion_score", text: "0°"
    expect(page).to have_selector ".right_wrist_flexion_score", text: "0°"
    expect(page).to have_selector ".right_hip_flexion_score", text: "0°"
  end

  scenario "destory patient rom", js: true do
    visit patient_rom_scales_path second_patient
    expect(page).to have_selector ".rom0-limit-part-count",
                                  text: "5箇所に可動域制限があります。"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).not_to have_selector ".rom0-limit-part-count",
                                      text: "5箇所に可動域制限があります。"
  end

  scenario "show patient page part of rom" do
    visit patient_path second_patient
    expect(page).to have_selector ".rom-limit-part-count", text: "可動域制限: 5箇所"
    expect(page).to have_selector ".rom-limit-part",
                                  text: "右肩関節屈曲 左肩関節屈曲 右肩関節伸展 右前腕回外 右手関節背屈"
  end
end
