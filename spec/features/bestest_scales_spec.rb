require 'rails_helper'

RSpec.feature "BestestScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_first_bestest_scale) do
    create(:bestest_scale, from_sitting_to_standing: "zero",
                           standing_on_tiptoes: "one",
                           standing_on_one_leg: "one",
                           forward_step: "two",
                           patient: second_patient)
  end
  let!(:second_patient_bestest_scales) do
    create_list(:bestest_scale, 5, back_step: "one",
                                   lateral_step: "one",
                                   standing: "one",
                                   standing_with_eyes_close: "one",
                                   standing_on_the_slope: "one",
                                   patient: second_patient)
  end
  let!(:second_patient_latest_bestest_scale) do
    create(:bestest_scale, change_walking_speed: "two",
                           walking_with_rotating_the_head: "two",
                           pibot_turn: "two",
                           straddling_obstacles: "two",
                           tug: "two",
                           patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create a patient bestest" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "Mini-BESTest"
    expect(page).not_to have_selector ".defined-scale", text: "Mini-BESTest"
    click_on "Mini-BESTest"
    expect(page).to have_current_path new_patient_bestest_scale_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "0)重度", from: "bestest_scale[from_sitting_to_standing]"
    select "1)中等度", from: "bestest_scale[standing_on_tiptoes]"
    select "2)正常", from: "bestest_scale[standing_on_one_leg]"
    click_on "保存する"
    expect(page).to have_current_path patient_bestest_scales_path(first_patient)
    expect(page).to have_selector ".bestest0_apa_score", text: "3"
    expect(page).to have_selector ".bestest0_total_score", text: "3"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集する"
    expect(page).to have_link "削除する"
    click_on "患者ページに戻る"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "Mini-BESTest"
    expect(page).not_to have_selector ".undefined-scale", text: "Mini-BESTest"
  end

  scenario "patient bestest index page" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "Mini-BESTest"
    expect(page).not_to have_selector ".undefined-scale", text: "Mini-BESTest"
    click_on "Mini-BESTest"
    expect(page).to have_current_path patient_bestest_scales_path(second_patient)
    expect(all(".bestest_score").size).to eq(7)
    expect(all(".show_link").size).to eq(7)
    expect(all(".edit_link").size).to eq(7)
    expect(all(".delete_link").size).to eq(7)
    expect(page).to have_selector ".bestest0_dynamic_walking_score", text: "10"
    expect(page).to have_selector ".bestest0_total_score", text: "10"
    expect(page).to have_selector ".bestest6_apa_score", text: "2"
    expect(page).to have_selector ".bestest6_cpa_score", text: "2"
    expect(page).to have_selector ".bestest6_total_score", text: "4"
  end

  scenario "show patient bestest page" do
    visit patient_bestest_scales_path second_patient
    find(".bestest6_show_link").click
    expect(page).to have_current_path patient_bestest_scale_path(
      second_patient, second_patient_first_bestest_scale
    )
    expect(page).to have_selector ".from_sitting_to_standing", text: "座位から立位"
    expect(page).to have_selector ".from_sitting_to_standing_score", text: "0)重度"
    expect(page).to have_selector ".standing_on_tiptoes", text: "爪先立ち"
    expect(page).to have_selector ".standing_on_tiptoes_score", text: "1)中等度"
    expect(page).to have_selector ".standing_on_one_leg", text: "片足立ち"
    expect(page).to have_selector ".standing_on_one_leg_score", text: "1)中等度"
    expect(page).to have_selector ".forward_step", text: "修正ステップ-前方"
    expect(page).to have_selector ".forward_step_score", text: "2)正常"
  end

  scenario "edit patient bestest" do
    visit patient_bestest_scales_path second_patient
    find(".bestest0_edit_link").click
    expect(page).to have_current_path edit_patient_bestest_scale_path(
      second_patient, second_patient_latest_bestest_scale
    )
    select "2)正常", from: "bestest_scale[from_sitting_to_standing]"
    select "2)正常", from: "bestest_scale[standing_on_tiptoes]"
    select "2)正常", from: "bestest_scale[standing_on_one_leg]"
    select "1)中等度", from: "bestest_scale[forward_step]"
    click_on "保存する"
    expect(page).to have_current_path patient_bestest_scales_path(second_patient)
    expect(page).to have_selector ".bestest0_apa_score", text: "6"
    expect(page).to have_selector ".bestest0_cpa_score", text: "1"
    expect(page).to have_selector ".bestest0_total_score", text: "7"
  end

  scenario "destory patient bestest", js: true do
    visit patient_bestest_scales_path second_patient
    page.accept_confirm do
      find(".bestest0_delete_link").click
    end
    expect(page).to have_current_path patient_bestest_scales_path second_patient
    expect(all(".bestest_score").size).to eq(6)
    expect(page).to have_selector ".bestest0_cpa_score", text: "2"
    expect(page).to have_selector ".bestest0_sensory_function_score", text: "3"
    expect(page).to have_selector ".bestest0_total_score", text: "5"
  end
end
