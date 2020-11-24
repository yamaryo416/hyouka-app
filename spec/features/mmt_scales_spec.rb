require "rails_helper"

RSpec.feature "MmtScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_mmt) do
    create(:mmt_scale, right_shoulder_flexion: "normal",
                       right_hip_adduction: "trace",
                       left_ankle_extension: "trace_poor",
                       patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient mmt" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "MMT"
    expect(page).not_to have_selector ".defined-scale", text: "MMT"
    click_on "MMT"
    expect(page).to have_current_path new_patient_mmt_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    click_button "肩関節"
    select "0", from: "mmt_scale[neck_flexion]"
    select "4", from: "mmt_scale[left_shoulder_external_rotation]"
    select "2-", from: "mmt_scale[right_ankle_extension]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "MMT"
    expect(page).not_to have_selector ".undefined-scale", text: "MMT"
    click_on "MMT"
    expect(page).to have_current_path patient_mmt_scales_path(first_patient)
    click_button "肩関節"
    expect(page).to have_selector ".neck_flexion_score", text: "0"
    expect(page).to have_selector ".left_shoulder_external_rotation_score", text: "4"
    expect(page).to have_selector ".right_ankle_extension_score", text: "2-"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "MMTを編集する"
    expect(page).to have_link "MMTを削除する"
  end

  scenario "edit patient mmt" do
    visit patient_mmt_scales_path second_patient
    click_on "MMTを編集する"
    expect(page).to have_current_path edit_patient_mmt_scales_path second_patient
    click_button "肘関節・前腕"
    click_button "手関節"
    click_button "股関節"
    select "0", from: "mmt_scale[right_shoulder_flexion]"
    select "1", from: "mmt_scale[right_hip_adduction]"
    select "5", from: "mmt_scale[left_ankle_extension]"
    click_on "保存する"
    expect(page).to have_current_path patient_mmt_scales_path second_patient
    click_button "肘関節・前腕"
    click_button "手関節"
    click_button "股関節"
    expect(page).to have_selector ".right_shoulder_flexion_score", text: "0"
    expect(page).to have_selector ".right_hip_adduction_score", text: "1"
    expect(page).to have_selector ".left_ankle_extension_score", text: "5"
  end

  scenario "destory patient mmt", js: true do
    visit patient_mmt_scales_path second_patient
    page.accept_confirm do
      click_on "MMTを削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "MMT"
    expect(page).not_to have_selector ".defined-scale", text: "MMT"
  end
end
