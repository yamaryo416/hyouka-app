require 'rails_helper'

RSpec.feature "BrsScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_brs) do
    create(:brs_scale, upper_limb: "stage_four",
                       finger: "stage_five",
                       lower_limb: "stage_six",
                       patient: second_patient)
  end
  let!(:oldest_third_patient_brs) do
    create(:brs_scale, upper_limb: "stage_one",
                       finger: "stage_one",
                       lower_limb: "stage_one",
                       patient: third_patient)
  end
  let!(:thrid_patient_brs) do
    create_list(:brs_scale, 5, upper_limb: "stage_six", patient: third_patient)
  end
  let!(:latest_third_patient_brs) do
    create(:brs_scale, upper_limb: "stage_three",
                       finger: "stage_three",
                       lower_limb: "stage_three",
                       patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient brs" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "BRS"
    expect(page).not_to have_selector ".defined-scale", text: "BRS"
    click_on "BRS"
    expect(page).to have_current_path new_patient_brs_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "BRS作成"
    select "ステージI",
           from: "brs_scale[upper_limb]"
    select "ステージⅢ",
           from: "brs_scale[finger]"
    select "ステージⅥ",
           from: "brs_scale[lower_limb]"
    click_on "保存する"
    expect(page).to have_current_path patient_brs_scales_path(first_patient)
    expect(page).to have_selector ".brs0-upper-limb-score",
                                  text: "ステージI"
    expect(page).to have_selector ".brs0-finger-score",
                                  text: "ステージⅢ"
    expect(page).to have_selector ".brs0-lower-limb-score",
                                  text: "ステージⅥ"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient brs" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "BRS"
    expect(page).not_to have_selector ".undefined-scale", text: "BRS"
    click_on "BRS"
    expect(page).to have_current_path patient_brs_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_brs_scale_path(
      second_patient, second_patient_brs
    )
    expect(page).to have_selector ".page-title", text: "BRS"
    expect(page).to have_selector ".upper_limb_score",
                                  text: "ステージⅣ"
    expect(page).to have_selector ".finger_score",
                                  text: "ステージⅤ"
    expect(page).to have_selector ".lower_limb_score",
                                  text: "ステージⅥ"
    expect(page).to have_link "BRS一覧"
    expect(page).to have_link "BRSを編集"
    expect(page).to have_link "BRSを削除"
  end

  scenario "index patient brs" do
    visit patient_brs_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "BRS一覧"
    expect(page).to have_selector ".brs0-upper-limb-score",
                                  text: "ステージⅢ"
    expect(page).to have_selector ".brs0-finger-score",
                                  text: "ステージⅢ"
    expect(page).to have_selector ".brs0-lower-limb-score",
                                  text: "ステージⅢ"
    expect(page).to have_selector ".brs6-upper-limb-score",
                                  text: "ステージI"
    expect(page).to have_selector ".brs6-finger-score",
                                  text: "ステージI"
    expect(page).to have_selector ".brs6-lower-limb-score",
                                  text: "ステージI"
  end

  scenario "edit patient brs" do
    visit patient_brs_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_brs_scale_path(
      second_patient, second_patient_brs
    )
    expect(page).to have_selector ".page-title", text: "BRS編集"
    select "ステージI",
           from: "brs_scale[upper_limb]"
    select "ステージⅡ",
           from: "brs_scale[finger]"
    select "ステージⅢ",
           from: "brs_scale[lower_limb]"
    click_on "保存する"
    expect(page).to have_current_path patient_brs_scales_path second_patient
    expect(page).to have_selector ".brs0-upper-limb-score",
                                  text: "ステージI"
    expect(page).to have_selector ".brs0-finger-score",
                                  text: "ステージⅡ"
    expect(page).to have_selector ".brs0-lower-limb-score",
                                  text: "ステージⅢ"
  end

  scenario "destory patient brs", js: true do
    visit patient_brs_scales_path second_patient
    expect(page).to have_selector ".brs0-upper-limb-score",
                                  text: "ステージⅣ"
    expect(page).to have_selector ".brs0-finger-score",
                                  text: "ステージⅤ"
    expect(page).to have_selector ".brs0-lower-limb-score",
                                  text: "ステージⅥ"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_brs_scales_path second_patient
    expect(page).not_to have_selector ".brs0-upper-limb-score",
                                      text: "ステージⅣ"
    expect(page).not_to have_selector ".brs0-finger-score",
                                      text: "ステージⅤ"
    expect(page).not_to have_selector ".brs0-lower-limb-score",
                                      text: "ステージⅥ"
  end

  scenario "show patient page part of brs" do
    visit patient_path second_patient
    expect(page).to have_selector ".brs-upper_limb", text: "上肢: ステージⅣ"
    expect(page).to have_selector ".brs-finger", text: "手指: ステージⅤ"
    expect(page).to have_selector ".brs-lower_limb", text: "下肢: ステージⅥ"
  end
end
