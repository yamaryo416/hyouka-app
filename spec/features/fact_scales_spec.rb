require 'rails_helper'

RSpec.feature "FactScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_first_fact_scale) do
    create(:fact_scale, sitting_with_upper_limb_support: "possible",
                        sitting_with_no_support: "possible",
                        lower_lateral_dynamic_sitting: "possible",
                        patient: second_patient)
  end
  let!(:second_patient_fact_scales) do
    create_list(:fact_scale, 5, forward_dynamic_sitting: "possible",
                                lateral_dynamic_sitting: "both_sides",
                                rear_lateral_dynamic_sitting: "both_sides",
                                patient: second_patient)
  end
  let!(:second_patient_latest_fact_scale) do
    create(:fact_scale, rear_dynamic_sitting: "possible",
                        lateral_dynamic_sitting_with_trunk_rotation: "possible",
                        trunk_rotation: "possible",
                        trunk_extenxion: "possible",
                        patient: second_patient)
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
    expect(page).to have_content first_patient.unique_id
    select "可能:1点", from: "fact_scale[sitting_with_upper_limb_support]"
    select "可能:1点", from: "fact_scale[sitting_with_no_support]"
    select "可能:1点", from: "fact_scale[lower_lateral_dynamic_sitting]"
    click_on "保存する"
    expect(page).to have_current_path patient_fact_scales_path(first_patient)
    expect(page).to have_selector ".fact0_total_score", text: "3"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集する"
    expect(page).to have_link "削除する"
    click_on "患者ページに戻る"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "FACT"
    expect(page).not_to have_selector ".undefined-scale", text: "FACT"
  end

  scenario "patient fact index page" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "FACT"
    expect(page).not_to have_selector ".undefined-scale", text: "FACT"
    click_on "FACT"
    expect(page).to have_current_path patient_fact_scales_path(second_patient)
    expect(all(".fact_score").size).to eq(7)
    expect(all(".show_link").size).to eq(7)
    expect(all(".edit_link").size).to eq(7)
    expect(all(".delete_link").size).to eq(7)
    expect(page).to have_selector ".fact0_total_score", text: "11"
    expect(page).to have_selector ".fact6_total_score", text: "3"
  end

  scenario "show patient fact page" do
    visit patient_fact_scales_path second_patient
    find(".fact6_show_link").click
    expect(page).to have_current_path patient_fact_scale_path(
      second_patient, second_patient_first_fact_scale
    )
    expect(page).to have_selector ".sitting_with_upper_limb_support", text: "静的座位保持能力(上肢支持利用)"
    expect(page).to have_selector ".sitting_with_upper_limb_support_score", text: "可能:1点"
    expect(page).to have_selector ".sitting_with_no_support", text: "静的座位保持能力(上肢支持不使用)"
    expect(page).to have_selector ".sitting_with_no_support_score", text: "可能:1点"
    expect(page).to have_selector ".lower_lateral_dynamic_sitting", text: "下方へのリーチに伴う動的座位保持能力"
    expect(page).to have_selector ".lower_lateral_dynamic_sitting_score", text: "可能:1点"
  end

  scenario "edit patient fact" do
    visit patient_fact_scales_path second_patient
    find(".fact0_edit_link").click
    expect(page).to have_current_path edit_patient_fact_scale_path(
      second_patient, second_patient_latest_fact_scale
    )
    select "不能:0点", from: "fact_scale[rear_dynamic_sitting]"
    select "不能:0点", from: "fact_scale[lateral_dynamic_sitting_with_trunk_rotation]"
    select "不能:0点", from: "fact_scale[trunk_rotation]"
    select "不能:0点", from: "fact_scale[trunk_extenxion]"
    click_on "保存する"
    expect(page).to have_current_path patient_fact_scales_path(second_patient)
    expect(page).to have_selector ".fact0_total_score", text: "0"
  end

  scenario "destory patient fact", js: true do
    visit patient_fact_scales_path second_patient
    page.accept_confirm do
      find(".fact0_delete_link").click
    end
    expect(page).to have_current_path patient_fact_scales_path second_patient
    expect(all(".fact_score").size).to eq(6)
    expect(page).to have_selector ".fact0_total_score", text: "6"
  end
end
