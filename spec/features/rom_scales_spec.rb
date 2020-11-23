require "rails_helper"

RSpec.feature "RomScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_rom) do
    create(:rom_scale, right_shoulder_flexion: 90,
                       left_shoulder_flexion: 60,
                       right_shoulder_extension: 45,
                       patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient rom" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "ROM"
    expect(page).not_to have_selector ".defined-scale", text: "ROM"
    click_on "ROM"
    expect(page).to have_current_path new_patient_rom_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    click_button "肩関節"
    fill_in "right_shoulder_flexion_form", with: 90
    fill_in "left_shoulder_flexion_form", with: 45
    fill_in "right_shoulder_extension_form", with: 20
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "ROM"
    expect(page).not_to have_selector ".undefined-scale", text: "ROM"
    click_on "ROM"
    expect(page).to have_current_path patient_rom_scales_path(first_patient)
    click_button "肩関節"
    expect(page).to have_selector ".right_shoulder_flexion_score", text: "90"
    expect(page).to have_selector ".left_shoulder_flexion_score", text: "45"
    expect(page).to have_selector ".right_shoulder_extension_score", text: "20"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "ROMを編集する"
    expect(page).to have_link "ROMを削除する"
  end

  scenario "edit patient rom" do
    visit patient_rom_scales_path second_patient
    click_on "ROMを編集する"
    expect(page).to have_current_path edit_patient_rom_scales_path second_patient
    click_button "肘関節・前腕"
    click_button "手関節"
    click_button "股関節"
    fill_in "right_elbow_flexion_form", with: 20
    fill_in "right_wrist_flexion_form", with: 30
    fill_in "right_hip_flexion_form", with: 40
    click_on "保存する"
    expect(page).to have_current_path patient_rom_scales_path second_patient
    click_button "肘関節・前腕"
    click_button "手関節"
    click_button "股関節"
    expect(page).to have_selector ".right_elbow_flexion_score", text: 20
    expect(page).to have_selector ".right_wrist_flexion_score", text: 30
    expect(page).to have_selector ".right_hip_flexion_score", text: 40
  end

  scenario "destory patient sias", js: true do
    visit patient_rom_scales_path second_patient
    page.accept_confirm do
      click_on "ROMを削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "ROM"
    expect(page).not_to have_selector ".defined-scale", text: "ROM"
  end
end
