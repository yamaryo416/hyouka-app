require 'rails_helper'

RSpec.feature "TactileScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_tactile) do
    create(:tactile_scale, right_upper_arm: "absent",
                           left_upper_arm: "impaired",
                           right_forearm: "normal",
                           patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient tactile" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "触覚検査"
    expect(page).not_to have_selector ".defined-scale", text: "触覚検査"
    click_on "触覚検査"
    expect(page).to have_current_path new_patient_tactile_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "脱失", from: "tactile_scale[left_forearm]"
    select "鈍麻", from: "tactile_scale[left_thigh]"
    select "正常", from: "tactile_scale[right_rearfoot]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "触覚検査"
    expect(page).not_to have_selector ".undefined-scale", text: "触覚検査"
    click_on "触覚検査"
    expect(page).to have_current_path patient_tactile_scales_path(first_patient)
    expect(page).to have_selector ".left_forearm_score", text: "脱失"
    expect(page).to have_selector ".left_thigh_score", text: "鈍麻"
    expect(page).to have_selector ".right_rearfoot_score", text: "正常"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "触覚検査を編集する"
    expect(page).to have_link "触覚検査を削除する"
  end

  scenario "edit patient tactile" do
    visit patient_tactile_scales_path second_patient
    click_on "触覚検査を編集する"
    expect(page).to have_current_path edit_patient_tactile_scales_path second_patient
    select "正常", from: "tactile_scale[right_upper_arm]"
    select "脱失", from: "tactile_scale[left_upper_arm]"
    select "鈍麻", from: "tactile_scale[right_forearm]"
    click_on "保存する"
    expect(page).to have_current_path patient_tactile_scales_path second_patient
    expect(page).to have_selector ".right_upper_arm_score", text: "正常"
    expect(page).to have_selector ".left_upper_arm_score", text: "脱失"
    expect(page).to have_selector ".right_forearm_score", text: "鈍麻"
  end

  scenario "destory patient tactile", js: true do
    visit patient_tactile_scales_path second_patient
    page.accept_confirm do
      click_on "触覚検査を削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "触覚検査"
    expect(page).not_to have_selector ".defined-scale", text: "触覚検査"
  end
end
