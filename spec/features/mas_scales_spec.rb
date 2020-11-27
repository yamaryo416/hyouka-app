require 'rails_helper'

RSpec.feature "MasScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_mas) do
    create(:mas_scale, elbow_joint: "no_enhancement",
                       wrist_joint: "mild_increase",
                       knee_joint: "significant",
                       patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient mas" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "MAS"
    expect(page).not_to have_selector ".defined-scale", text: "MAS"
    click_on "MAS"
    expect(page).to have_current_path new_patient_mas_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "2", from: "mas_scale[wrist_joint]"
    select "1+", from: "mas_scale[knee_joint]"
    select "3", from: "mas_scale[ankle_joint]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "MAS"
    expect(page).not_to have_selector ".undefined-scale", text: "MAS"
    click_on "MAS"
    expect(page).to have_current_path patient_mas_scales_path(first_patient)
    expect(page).to have_selector ".wrist_joint", text: "手関節"
    expect(page).to have_selector ".wrist_joint_score", text: "2"
    expect(page).to have_selector ".knee_joint", text: "膝関節"
    expect(page).to have_selector ".knee_joint_score", text: "1+"
    expect(page).to have_selector ".ankle_joint", text: "足関節"
    expect(page).to have_selector ".ankle_joint_score", text: "3"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "MASを編集する"
    expect(page).to have_link "MASを削除する"
  end

  scenario "edit patient mas" do
    visit patient_mas_scales_path second_patient
    click_on "MASを編集する"
    expect(page).to have_current_path edit_patient_mas_scales_path second_patient
    select "4", from: "mas_scale[elbow_joint]"
    select "4", from: "mas_scale[wrist_joint]"
    select "4", from: "mas_scale[knee_joint]"
    click_on "保存する"
    expect(page).to have_current_path patient_mas_scales_path second_patient
    expect(page).to have_selector ".elbow_joint", text: "肘関節"
    expect(page).to have_selector ".elbow_joint_score", text: "4"
    expect(page).to have_selector ".wrist_joint", text: "手関節"
    expect(page).to have_selector ".wrist_joint_score", text: "4"
    expect(page).to have_selector ".knee_joint", text: "膝関節"
    expect(page).to have_selector ".knee_joint_score", text: "4"
  end

  scenario "destory patient mas", js: true do
    visit patient_mas_scales_path second_patient
    page.accept_confirm do
      click_on "MASを削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "MAS"
    expect(page).not_to have_selector ".defined-scale", text: "MAS"
  end
end
