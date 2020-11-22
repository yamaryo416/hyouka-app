require 'rails_helper'

RSpec.feature "SiasScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_sias) do
    create(:sias_scale, shoulder_motor_function: "no_function",
                        finger_motor_function: "group_extension_possible",
                        hip_motor_function: "move_a_little",
                        patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient sias" do
    visit patient_path first_patient
    click_on "SIAS"
    expect(page).to have_current_path new_patient_sias_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "2:肩肘の共同運動があるが手部が口に届かない",
      from: "sias_scale[shoulder_motor_function]"
    select "1C:分離運動が一部可能",
      from: "sias_scale[finger_motor_function]"
    select "4:課題可能。軽度のぎこちなさあり",
      from: "sias_scale[hip_motor_function]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".sias-total-score", text: "7"
    expect(page).to have_selector ".undefined-columns-count",
      text: "19項目が未入力です。"
    click_on "SIAS"
    expect(page).to have_current_path patient_sias_scales_path(first_patient)
    expect(page).to have_selector ".shoulder_motor_function", text: "上肢近位"
    expect(page).to have_selector ".shoulder_motor_function_score",
      text: "2:肩肘の共同運動があるが手部が口に届かない"
    expect(page).to have_selector ".finger_motor_function", text: "上肢遠位"
    expect(page).to have_selector ".finger_motor_function_score",
      text: "1C:分離運動が一部可能"
    expect(page).to have_selector ".hip_motor_function", text: "下肢近位(股)"
    expect(page).to have_selector ".hip_motor_function_score",
      text: "4:課題可能。軽度のぎこちなさあり"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "SIASを編集する"
    expect(page).to have_link "SIASを削除する"
  end

  scenario "edit patient sias" do
    visit patient_sias_scales_path second_patient
    click_on "SIASを編集する"
    expect(page).to have_current_path edit_patient_sias_scales_path second_patient
    select "5:健側と変わらず、正常",
      from: "sias_scale[shoulder_motor_function]"
    select "3.課題可能。全指の分離運動が十分な屈曲伸展を伴って可能",
      from: "sias_scale[finger_motor_function]"
    select "4:課題可能。軽度のぎこちなさあり",
      from: "sias_scale[hip_motor_function]"
    click_on "保存する"
    expect(page).to have_current_path patient_sias_scales_path second_patient
    expect(page).to have_selector ".shoulder_motor_function", text: "上肢近位"
    expect(page).to have_selector ".shoulder_motor_function_score",
      text: "5:健側と変わらず、正常"
    expect(page).to have_selector ".finger_motor_function", text: "上肢遠位"
    expect(page).to have_selector ".finger_motor_function_score",
      text: "3.課題可能。全指の分離運動が十分な屈曲伸展を伴って可能"
    expect(page).to have_selector ".hip_motor_function", text: "下肢近位(股)"
    expect(page).to have_selector ".hip_motor_function_score",
      text: "4:課題可能。軽度のぎこちなさあり"
    expect(page).to have_selector ".sias-total-score", text: "12"
  end

  scenario "destory patient sias", js: true do
    visit patient_sias_scales_path second_patient
    page.accept_confirm do
      click_on "SIASを削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "SIAS"
    expect(page).not_to have_selector ".defined-scale", text: "SIAS"
  end
end
