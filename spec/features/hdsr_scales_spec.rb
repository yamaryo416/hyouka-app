require 'rails_helper'

RSpec.feature "hdsrScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_hdsr) do
    create(:hdsr_scale, age: 1,
                        year: 1,
                        month: 1,
                        patient: second_patient)
  end
  let!(:oldest_patient_hdsr_scales) do
    create(:hdsr_scale, day: 1,
                        day_of_the_week: 1,
                        first_three_word: 1,
                        second_three_word: 1,
                        third_three_word: 1,
                        patient: third_patient)
  end
  let!(:third_patient_hdsr) do
    create_list(:hdsr_scale, 5, revese_three_number: 1, patient: third_patient)
  end
  let!(:latest_third_patient_hdsr) do
    create(:hdsr_scale, place: 2,
                        memory_first_word: 2,
                        memory_second_word: 2,
                        memory_third_word: 2,
                        five_goods: 5,
                        vegetables: 5,
                        patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient hdsr" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "HDS-R"
    expect(page).not_to have_selector ".defined-scale", text: "HDS-R"
    click_on "HDS-R"
    expect(page).to have_current_path new_patient_hdsr_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "HDS-R作成"
    find("input[name='hdsr_scale[age]'][value='0']").set(true)
    find("input[name='hdsr_scale[year]'][value='0']").set(true)
    find("input[name='hdsr_scale[month]'][value='0']").set(true)
    click_on "保存する"
    expect(page).to have_current_path patient_hdsr_scales_path(first_patient)
    expect(page).to have_selector ".hdsr0-total-score", text: "0点"
    expect(page).to have_selector ".hdsr0-undefined-count",
                                  text: "15項目が未入力です。"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "index patient hdsr" do
    visit patient_hdsr_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "HDS-R一覧"
    expect(page).to have_selector ".hdsr0-total-score", text: "18点"
    expect(page).to have_selector ".hdsr0-undefined-count",
                                  text: "12項目が未入力です。"
    expect(page).to have_selector ".hdsr6-total-score", text: "5点"
    expect(page).to have_selector ".hdsr6-undefined-count",
                                  text: "13項目が未入力です。"
  end

  scenario "edit patient hdsr" do
    visit patient_hdsr_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_hdsr_scale_path(
      second_patient, second_patient_hdsr
    )
    expect(page).to have_selector ".page-title", text: "HDS-R編集"
    find("input[name='hdsr_scale[age]'][value='0']").set(true)
    find("input[name='hdsr_scale[year]'][value='0']").set(true)
    find("input[name='hdsr_scale[month]'][value='0']").set(true)
    click_on "保存する"
    expect(page).to have_current_path patient_hdsr_scales_path second_patient
    expect(page).to have_selector ".hdsr0-total-score", text: "0点"
    expect(page).to have_selector ".hdsr0-undefined-count",
                                  text: "15項目が未入力です。"
  end

  scenario "destory patient hdsr", js: true do
    visit patient_hdsr_scales_path second_patient
    expect(page).to have_selector ".hdsr0-total-score", text: "3点"
    expect(page).to have_selector ".hdsr0-undefined-count",
                                  text: "15項目が未入力です。"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_hdsr_scales_path second_patient
    expect(page).not_to have_selector ".hdsr0-total-score", text: "3点"
    expect(page).not_to have_selector ".hdsr0-undefined-count",
                                      text: "15項目が未入力です。"
  end

  scenario "show patient page part of hdsr" do
    visit patient_path second_patient
    expect(page).to have_selector ".hdsr-total-score", text: "合計　3点"
    expect(page).to have_selector ".hdsr-undefined-columns-count", text: "*15項目が未入力です。"
  end
end
