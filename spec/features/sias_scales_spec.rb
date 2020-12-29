require 'rails_helper'

RSpec.feature "SiasScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_sias) do
    create(:sias_scale, shoulder_motor_function: "no_function",
                        finger_motor_function: "group_extension_possible",
                        hip_motor_function: "move_a_little",
                        patient: second_patient)
  end
  let!(:oldest_third_patient_sias) do
    create(:sias_scale, upper_limb_muscle_tone: "normal",
                        lower_limb_muscle_tone: "normal",
                        upper_limb_tendon_reflex: "normal",
                        lower_limb_tendon_reflex: "normal",
                        upper_limb_tactile: "normal",
                        lower_limb_tactile: "normal",
                        patient: third_patient)
  end
  let!(:thrid_patient_sias) do
    create_list(:sias_scale, 5, pain: "milde", patient: third_patient)
  end
  let!(:latest_third_patient_sias) do
    create(:sias_scale, visuospatial_cognition: "very_slight_error",
                        speech: "normal",
                        gripstrength: "fair",
                        quadriceps_mmt: "poor",
                        patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient sias" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "SIAS"
    expect(page).not_to have_selector ".defined-scale", text: "SIAS"
    click_on "SIAS"
    expect(page).to have_current_path new_patient_sias_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "SIAS作成"
    select "2:肩肘の共同運動があるが手部が口に届かない",
           from: "sias_scale[shoulder_motor_function]"
    select "1C:分離運動が一部可能",
           from: "sias_scale[finger_motor_function]"
    select "4:課題可能。軽度のぎこちなさあり",
           from: "sias_scale[hip_motor_function]"
    click_on "保存する"
    expect(page).to have_current_path patient_sias_scales_path(first_patient)
    expect(page).to have_selector ".sias0-total-score", text: "7点"
    expect(page).to have_selector ".sias0-undefined-count",
                                  text: "19項目が未入力です。"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient sias" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "SIAS"
    expect(page).not_to have_selector ".undefined-scale", text: "SIAS"
    click_on "SIAS"
    expect(page).to have_current_path patient_sias_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_sias_scale_path(
      second_patient, second_patient_sias
    )
    expect(page).to have_selector ".page-title", text: "SIAS"
    expect(page).to have_selector ".shoulder_motor_function_score",
                                  text: "0:全く動かない"
    expect(page).to have_selector ".finger_motor_function_score",
                                  text: "1B:集団伸展が可能"
    expect(page).to have_selector ".hip_motor_function_score",
                                  text: "2:股関節の屈曲運動あり、足部は床より離れるが十分ではない"
    expect(page).to have_link "SIAS一覧"
    expect(page).to have_link "SIASを編集"
    expect(page).to have_link "SIASを削除"
  end

  scenario "index patient sias" do
    visit patient_sias_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "SIAS一覧"
    expect(page).to have_selector ".sias0-total-score", text: "9点"
    expect(page).to have_selector ".sias0-undefined-count",
                                  text: "18項目が未入力です。"
    expect(page).to have_selector ".sias6-total-score", text: "18点"
    expect(page).to have_selector ".sias6-undefined-count",
                                  text: "16項目が未入力です。"
  end

  scenario "edit patient sias" do
    visit patient_sias_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_sias_scale_path(
      second_patient, second_patient_sias
    )
    expect(page).to have_selector ".page-title", text: "SIAS編集"
    select "5:健側と変わらず、正常",
           from: "sias_scale[shoulder_motor_function]"
    select "3.課題可能。全指の分離運動が十分な屈曲伸展を伴って可能",
           from: "sias_scale[finger_motor_function]"
    select "4:課題可能。軽度のぎこちなさあり",
           from: "sias_scale[hip_motor_function]"
    click_on "保存する"
    expect(page).to have_current_path patient_sias_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".shoulder_motor_function_score",
                                  text: "5:健側と変わらず、正常"
    expect(page).to have_selector ".finger_motor_function_score",
                                  text: "3.課題可能。全指の分離運動が十分な屈曲伸展を伴って可能"
    expect(page).to have_selector ".hip_motor_function_score",
                                  text: "4:課題可能。軽度のぎこちなさあり"
    expect(page).to have_selector ".sias-total-score", text: "12"
  end

  scenario "destory patient sias", js: true do
    visit patient_sias_scales_path second_patient
    expect(page).to have_selector ".sias0-total-score", text: "3"
    expect(page).to have_selector ".sias0-undefined-count",
                                  text: "19項目が未入力です。"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_sias_scales_path second_patient
    expect(page).not_to have_selector ".sias0-total-score", text: "3"
    expect(page).not_to have_selector ".sias0-undefined-count",
                                      text: "19項目が未入力です。"
  end

  scenario "show patient page part of sias" do
    visit patient_path second_patient
    expect(page).to have_selector ".sias-total-score", text: "合計　3点"
    expect(page).to have_selector ".sias-undefined-columns-count", text: "*19項目が未入力です。"
  end
end
