require 'rails_helper'

RSpec.feature "FactScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_fact) do
    create(:fact_scale, sitting_with_upper_limb_support: "possible",
                        sitting_with_no_support: "possible",
                        lower_lateral_dynamic_sitting: "possible",
                        patient: second_patient)
  end
  let!(:oldest_third_patient_fact) do
    create(:fact_scale, forward_dynamic_sitting: "possible",
                        lateral_dynamic_sitting: "both_sides",
                        patient: third_patient)
  end
  let!(:third_patient_facts) do
    create_list(:fact_scale, 5, rear_lateral_dynamic_sitting: "both_sides",
                                patient: third_patient)
  end
  let!(:latest_third_patient_fact) do
    create(:fact_scale, rear_dynamic_sitting: "possible",
                        lateral_dynamic_sitting_with_trunk_rotation: "possible",
                        trunk_rotation: "possible",
                        trunk_extenxion: "possible",
                        patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create a patient fact" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "FACT"
    expect(page).not_to have_selector ".defined-scale", text: "FACT"
    click_on "FACT"
    expect(page).to have_current_path new_patient_fact_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "FACT作成"
    select "可能:1点", from: "fact_scale[sitting_with_upper_limb_support]"
    select "可能:1点", from: "fact_scale[sitting_with_no_support]"
    select "可能:1点", from: "fact_scale[lower_lateral_dynamic_sitting]"
    click_on "保存する"
    expect(page).to have_current_path patient_fact_scales_path(first_patient)
    expect(page).to have_selector ".fact0-total-score", text: "3点"
    expect(page).to have_selector ".fact0-undefined-count",
                                  text: "7項目が未入力です。"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient fact" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "FACT"
    expect(page).not_to have_selector ".undefined-scale", text: "FACT"
    click_on "FACT"
    expect(page).to have_current_path patient_fact_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_fact_scale_path(
      second_patient, second_patient_fact
    )
    expect(page).to have_selector ".page-title", text: "FACT"
    expect(page).to have_selector ".fact-total-score", text: "3点"
    expect(page).to have_selector ".sitting_with_upper_limb_support_score",
                                  text: "可能:1点"
    expect(page).to have_selector ".sitting_with_no_support_score",
                                  text: "可能:1点"
    expect(page).to have_selector ".lower_lateral_dynamic_sitting_score",
                                  text: "可能:1点"
  end

  scenario "index patient fact" do
    visit patient_fact_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "FACT一覧"
    expect(page).to have_selector ".fact0-total-score", text: "11点"
    expect(page).to have_selector ".fact0-undefined-count",
                                  text: "6項目が未入力です。"
    expect(page).to have_selector ".fact6-total-score", text: "4点"
    expect(page).to have_selector ".fact6-undefined-count",
                                  text: "8項目が未入力です。"
  end

  scenario "edit patient fact" do
    visit patient_fact_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_fact_scale_path(
      second_patient, second_patient_fact
    )
    expect(page).to have_selector ".page-title", text: "FACT編集"
    select "不能:0点", from: "fact_scale[sitting_with_upper_limb_support]"
    select "不能:0点", from: "fact_scale[sitting_with_no_support]"
    select "不能:0点", from: "fact_scale[lower_lateral_dynamic_sitting]"
    click_on "保存する"
    expect(page).to have_current_path patient_fact_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".fact-total-score", text: "0点"
    expect(page).to have_selector ".sitting_with_upper_limb_support_score",
                                  text: "不能:0点"
    expect(page).to have_selector ".sitting_with_no_support_score",
                                  text: "不能:0点"
    expect(page).to have_selector ".lower_lateral_dynamic_sitting_score",
                                  text: "不能:0点"
  end

  scenario "destory patient fact", js: true do
    visit patient_fact_scales_path second_patient
    expect(page).to have_selector ".fact0-total-score", text: "3点"
    expect(page).to have_selector ".fact0-undefined-count",
                                  text: "7項目が未入力です。"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).not_to have_selector ".fact0-total-score", text: "3点"
    expect(page).not_to have_selector ".fact0-undefined-count",
                                      text: "7項目が未入力です。"
  end

  scenario "show patient page part of fact" do
    visit patient_path second_patient
    expect(page).to have_selector ".fact-total-score", text: "合計　3点"
    expect(page).to have_selector ".fact-undefined-columns-count", text: "*7項目が未入力です。"
  end
end
