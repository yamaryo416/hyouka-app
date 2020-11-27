require 'rails_helper'

RSpec.feature "BrsScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_brs) do
    create(:brs_scale, upper_limbs: "stage_four",
                       finger: "stage_five",
                       lower_limbs: "stage_six",
                       patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient brs" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "BRS"
    expect(page).not_to have_selector ".defined-scale", text: "BRS"
    click_on "BRS"
    expect(page).to have_current_path new_patient_brs_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "ステージⅣ:痙性減弱期",
           from: "brs_scale[upper_limbs]"
    select "ステージⅤ:巧緻性の出現",
           from: "brs_scale[finger]"
    select "ステージⅥ:痙性最小期",
           from: "brs_scale[lower_limbs]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "BRS"
    expect(page).not_to have_selector ".undefined-scale", text: "BRS"
    click_on "BRS"
    expect(page).to have_current_path patient_brs_scales_path(first_patient)
    expect(page).to have_selector ".upper_limbs", text: "上肢"
    expect(page).to have_selector ".upper_limbs_score",
                                  text: "ステージⅣ:痙性減弱期"
    expect(page).to have_selector ".finger", text: "手指"
    expect(page).to have_selector ".finger_score",
                                  text: "ステージⅤ:巧緻性の出現"
    expect(page).to have_selector ".lower_limbs", text: "下肢"
    expect(page).to have_selector ".lower_limbs_score",
                                  text: "ステージⅥ:痙性最小期"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "BRSを編集する"
    expect(page).to have_link "BRSを削除する"
  end

  scenario "edit patient brs" do
    visit patient_brs_scales_path second_patient
    click_on "BRSを編集する"
    expect(page).to have_current_path edit_patient_brs_scales_path second_patient
    select "ステージI:弛緩性麻痺",
           from: "brs_scale[upper_limbs]"
    select "ステージⅡ:随意性の出現",
           from: "brs_scale[finger]"
    select "ステージⅢ:痙性期",
           from: "brs_scale[lower_limbs]"
    click_on "保存する"
    expect(page).to have_current_path patient_brs_scales_path second_patient
    expect(page).to have_selector ".upper_limbs", text: "上肢"
    expect(page).to have_selector ".upper_limbs_score",
                                  text: "ステージI:弛緩性麻痺"
    expect(page).to have_selector ".finger", text: "手指"
    expect(page).to have_selector ".finger_score",
                                  text: "ステージⅡ:随意性の出現"
    expect(page).to have_selector ".lower_limbs", text: "下肢"
    expect(page).to have_selector ".lower_limbs_score",
                                  text: "ステージⅢ:痙性期"
  end

  scenario "destory patient brs", js: true do
    visit patient_brs_scales_path second_patient
    page.accept_confirm do
      click_on "BRSを削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "BRS"
    expect(page).not_to have_selector ".defined-scale", text: "BRS"
  end
end
