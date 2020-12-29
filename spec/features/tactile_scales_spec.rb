require 'rails_helper'

RSpec.feature "TactileScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_tactile) do
    create(:tactile_scale, right_upper_arm: "absent",
                           left_upper_arm: "impaired",
                           right_forearm: "impaired",
                           patient: second_patient)
  end
  let!(:oldest_third_patient_tactile) do
    create(:tactile_scale, left_forearm: "absent",
                           right_hand: "absent",
                           patient: third_patient)
  end
  let!(:third_patient_tactiles) do
    create_list(:tactile_scale, 5, left_hand: "absent", patient: third_patient)
  end
  let!(:latest_third_patient_tactile) do
    create(:tactile_scale, right_thigh: "absent",
                           left_thigh: "absent",
                           right_lower_leg: "absent",
                           left_lower_leg: "absent",
                           right_rearfoot: "impaired",
                           left_rearfoot: "impaired",
                           right_forefoot: "impaired",
                           left_forefoot: "impaired",
                           patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient tactile" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "触覚検査"
    expect(page).not_to have_selector ".defined-scale", text: "触覚検査"
    click_on "触覚検査"
    expect(page).to have_current_path new_patient_tactile_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "触覚検査作成"
    select "脱失", from: "tactile_scale[left_forearm]"
    select "鈍麻", from: "tactile_scale[left_thigh]"
    select "脱失", from: "tactile_scale[right_rearfoot]"
    click_on "保存する"
    expect(page).to have_current_path patient_tactile_scales_path(first_patient)
    expect(page).to have_selector ".tactile0-limit-part", text: "3箇所"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient tactile" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "触覚検査"
    expect(page).not_to have_selector ".undefined-scale", text: "触覚検査"
    click_on "触覚検査"
    expect(page).to have_current_path patient_tactile_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".page-title", text: "触覚検査"
    expect(page).to have_current_path patient_tactile_scale_path(
      second_patient, second_patient_tactile
    )
    expect(page).to have_selector ".limita-part-detail",
                                  text: "右上腕 左上腕 右前腕"
    expect(page).to have_selector ".right_upper_arm_score", text: "脱失"
    expect(page).to have_selector ".left_upper_arm_score", text: "鈍麻"
    expect(page).to have_selector ".right_forearm_score", text: "鈍麻"
    expect(page).to have_link "触覚検査一覧"
    expect(page).to have_link "触覚検査を編集"
    expect(page).to have_link "触覚検査を削除"
  end

  scenario "index patient tactile" do
    visit patient_tactile_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "触覚検査一覧"
    expect(page).to have_selector ".tactile0-limit-part",
                                  text: "8箇所"
    expect(page).to have_selector ".tactile6-limit-part",
                                  text: "2箇所"
  end

  scenario "edit patient tactile" do
    visit patient_tactile_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_tactile_scale_path(
      second_patient, second_patient_tactile
    )
    expect(page).to have_selector ".page-title", text: "触覚検査編集"
    select "正常", from: "tactile_scale[right_upper_arm]"
    select "脱失", from: "tactile_scale[left_upper_arm]"
    select "脱失", from: "tactile_scale[right_forearm]"
    click_on "保存する"
    expect(page).to have_current_path patient_tactile_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".right_upper_arm_score", text: "正常"
    expect(page).to have_selector ".left_upper_arm_score", text: "脱失"
    expect(page).to have_selector ".right_forearm_score", text: "脱失"
  end

  scenario "destory patient tactile", js: true do
    visit patient_tactile_scales_path second_patient
    expect(page).to have_selector ".tactile0-limit-part",
                                  text: "3箇所"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_tactile_scales_path second_patient
    expect(page).not_to have_selector ".tactile0-limit-part",
                                      text: "3箇所"
  end

  scenario "show patient page part of tactile" do
    visit patient_path second_patient
    expect(page).to have_selector ".tactile-limit-part-count",
                                  text: "機能低下: 3箇所"
    expect(page).to have_selector ".tactile-limit-part",
                                  text: "右上腕 左上腕 右前腕"
  end
end
