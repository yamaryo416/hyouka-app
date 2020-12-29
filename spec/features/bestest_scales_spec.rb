require 'rails_helper'

RSpec.feature "BestestScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_bestest) do
    create(:bestest_scale, from_sitting_to_standing: "zero",
                           standing_on_tiptoes: "one",
                           standing_on_one_leg: "one",
                           forward_step: "two",
                           patient: second_patient)
  end
  let!(:oldest_third_patient_bestest) do
    create(:bestest_scale, back_step: "one",
                           lateral_step: "one",
                           standing: "one",
                           standing_with_eyes_close: "one",
                           patient: third_patient)
  end
  let!(:thrid_patient_bestests) do
    create_list(:bestest_scale, 5, standing_on_the_slope: "two", patient: third_patient)
  end
  let!(:latest_third_patient_bestest) do
    create(:bestest_scale, change_walking_speed: "two",
                           walking_with_rotating_the_head: "two",
                           pibot_turn: "two",
                           straddling_obstacles: "two",
                           tug: "two",
                           patient: third_patient)
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
    expect(page).to have_selector ".page-title", text: "Mini-BESTest作成"
    select "0)重度", from: "bestest_scale[from_sitting_to_standing]"
    select "1)中等度", from: "bestest_scale[standing_on_tiptoes]"
    select "2)正常", from: "bestest_scale[standing_on_one_leg]"
    click_on "保存する"
    expect(page).to have_current_path patient_bestest_scales_path(first_patient)
    expect(page).to have_selector ".bestest0-total-score", text: "3"
    expect(page).to have_selector ".bestest0-apa-score", text: "3"
    expect(page).to have_selector ".bestest0-undefined-count", text: "11項目が未入力です"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient bestest" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "Mini-BESTest"
    expect(page).not_to have_selector ".undefined-scale", text: "Mini-BESTest"
    click_on "Mini-BESTest"
    expect(page).to have_current_path patient_bestest_scales_path second_patient
    expect(page).to have_selector ".page-title", text: "Mini-BESTest"
    click_on "詳細"
    expect(page).to have_current_path patient_bestest_scale_path(
      second_patient, second_patient_bestest
    )
    expect(page).to have_selector ".bestest-apa-score", text: "2点"
    expect(page).to have_selector ".bestest-cpa-score", text: "2点"
    expect(page).to have_selector ".bestest-sensory-function-score", text: "0点"
    expect(page).to have_selector ".bestest-dynamic-walking-score", text: "0点"
    expect(page).to have_selector ".from_sitting_to_standing_score", text: "0)重度"
    expect(page).to have_selector ".standing_on_tiptoes_score", text: "1)中等度"
    expect(page).to have_selector ".standing_on_one_leg_score", text: "1)中等度"
    expect(page).to have_selector ".forward_step_score", text: "2)正常"
  end

  scenario "index patient bestest" do
    visit patient_bestest_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "Mini-BESTest一覧"
    expect(page).to have_selector ".bestest0-total-score", text: "10点"
    expect(page).to have_selector ".bestest0-dynamic-walking-score", text: "10点"
    expect(page).to have_selector ".bestest0-undefined-count",
                                  text: "9項目が未入力です。"
    expect(page).to have_selector ".bestest6-total-score", text: "4点"
    expect(page).to have_selector ".bestest6-cpa-score", text: "2点"
    expect(page).to have_selector ".bestest6-sensory-function-score", text: "2点"
    expect(page).to have_selector ".bestest6-undefined-count",
                                  text: "10項目が未入力です。"
  end

  scenario "edit patient bestest" do
    visit patient_bestest_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_bestest_scale_path(
      second_patient, second_patient_bestest
    )
    expect(page).to have_selector ".page-title", text: "Mini-BESTest編集"
    select "2)正常", from: "bestest_scale[from_sitting_to_standing]"
    select "2)正常", from: "bestest_scale[standing_on_tiptoes]"
    select "2)正常", from: "bestest_scale[standing_on_one_leg]"
    select "1)中等度", from: "bestest_scale[forward_step]"
    click_on "保存する"
    expect(page).to have_current_path patient_bestest_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".bestest-total-score", text: "7点"
    expect(page).to have_selector ".bestest-apa-score", text: "6点"
    expect(page).to have_selector ".bestest-cpa-score", text: "1点"
  end

  scenario "destory patient bestest", js: true do
    visit patient_bestest_scales_path second_patient
    expect(page).to have_selector ".bestest0-total-score", text: "4点"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_bestest_scales_path second_patient
    expect(page).not_to have_selector ".bestest0-total-score", text: "4点"
  end

  scenario "show patient page part of bestest" do
    visit patient_path second_patient
    expect(page).to have_selector ".bestest-total-score", text: "合計　4点"
    expect(page).to have_selector ".bestest-undefined-columns-count",
                                  text: "*10項目が未入力です"
  end
end
