require 'rails_helper'

RSpec.feature "NrsScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_nrs) do
    create(:nrs_scale, rating: 1,
                       status: "resting",
                       supplement: "痺れる痛み",
                       patient: second_patient)
  end
  let!(:oldest_third_patient_nrs) do
    create(:nrs_scale, rating: 10,
                       status: "loading",
                       supplement: "焼ける痛み",
                       patient: third_patient)
  end
  let!(:third_patient_nrss) do
    create_list(:nrs_scale, 5, rating: 8,
                               status: "resting",
                               supplement: "鋭い痛み",
                               patient: third_patient)
  end
  let!(:latest_third_patient_nrs) do
    create(:nrs_scale, rating: 4,
                       status: "moving",
                       supplement: "鈍い痛み",
                       patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create a patient nrs" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "NRS"
    expect(page).not_to have_selector ".defined-scale", text: "NRS"
    click_on "NRS"
    expect(page).to have_current_path new_patient_nrs_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "NRS作成"
    fill_in "NRS", with: 5
    select "荷重時", from: "nrs_scale[status]"
    fill_in "補足", with: "焼けるような痛み"
    click_on "保存する"
    expect(page).to have_current_path patient_nrs_scales_path(first_patient)
    expect(page).to have_selector ".nrs0-rating", text: "5"
    expect(page).to have_selector ".nrs0-status", text: "荷重時"
    expect(page).to have_selector ".nrs0-supplement", text: "焼けるような痛み"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "index patient nrs" do
    visit patient_nrs_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "NRS一覧"
    expect(page).to have_selector ".nrs0-rating", text: "4"
    expect(page).to have_selector ".nrs0-status", text: "体動時"
    expect(page).to have_selector ".nrs0-supplement", text: "鈍い痛み"
    expect(page).to have_selector ".nrs6-rating", text: "10"
    expect(page).to have_selector ".nrs6-status", text: "荷重時"
    expect(page).to have_selector ".nrs6-supplement", text: "焼ける痛み"
  end

  scenario "edit patient nrs" do
    visit patient_nrs_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_nrs_scale_path(
      second_patient, second_patient_nrs
    )
    expect(page).to have_selector ".page-title", text: "NRS編集"
    fill_in "NRS", with: "9"
    select "体動時", from: "nrs_scale[status]"
    fill_in "補足", with: "焼ける痛み"
    click_on "保存する"
    expect(page).to have_current_path patient_nrs_scales_path second_patient
    expect(page).to have_selector ".nrs0-rating", text: "9"
    expect(page).to have_selector ".nrs0-status", text: "体動時"
    expect(page).to have_selector ".nrs0-supplement", text: "焼ける痛み"
  end

  scenario "destory patient nrs", js: true do
    visit patient_nrs_scales_path second_patient
    expect(page).to have_selector ".nrs0-rating", text: "1"
    expect(page).to have_selector ".nrs0-status", text: "安静時"
    expect(page).to have_selector ".nrs0-supplement", text: "痺れる痛み"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_nrs_scales_path second_patient
    expect(page).not_to have_selector ".nrs0-rating", text: "1"
    expect(page).not_to have_selector ".nrs0-status", text: "安静時"
    expect(page).not_to have_selector ".nrs0-supplement", text: "痺れる痛み"
  end

  scenario "show patient page part of nrs" do
    visit patient_path second_patient
    expect(page).to have_selector ".nrs-status", text: "安静時 1"
    expect(page).to have_selector ".nrs-supplement", text: "痺れる痛み"
  end
end
