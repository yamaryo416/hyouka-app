require 'rails_helper'

RSpec.feature "NrsScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_first_nrs_scale) do
    create(:nrs_scale, rating: 1,
                       status: "resting",
                       supplement: "痺れる痛み",
                       patient: second_patient)
  end
  let!(:second_patient_nrs_scales) do
    create_list(:nrs_scale, 5, rating: 10,
                               status: "loading",
                               supplement: "焼ける痛み",
                               patient: second_patient)
  end
  let!(:second_patient_latest_nrs_scale) do
    create(:nrs_scale, rating: 4,
                       status: "moving",
                       supplement: "鈍い痛み",
                       patient: second_patient)
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
    expect(page).to have_content first_patient.unique_id
    fill_in "NRS", with: 5
    select "荷重時", from: "nrs_scale[status]"
    fill_in "補足", with: "焼けるような痛み"
    click_on "保存する"
    expect(page).to have_current_path patient_nrs_scales_path(first_patient)
    expect(page).to have_selector ".nrs0_rating", text: "5"
    expect(page).to have_selector ".nrs0_status", text: "荷重時"
    expect(page).to have_selector ".nrs0_supplement", text: "焼けるような痛み"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "編集する"
    expect(page).to have_link "削除する"
    click_on "患者ページに戻る"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "NRS"
    expect(page).not_to have_selector ".undefined-scale", text: "NRS"
  end

  scenario "patient nrs index page" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "NRS"
    expect(page).not_to have_selector ".undefined-scale", text: "NRS"
    click_on "NRS"
    expect(page).to have_current_path patient_nrs_scales_path(second_patient)
    expect(all(".nrs_score").size).to eq(7)
    expect(all(".edit_link").size).to eq(7)
    expect(all(".delete_link").size).to eq(7)
    expect(page).to have_selector ".nrs0_rating", text: "4"
    expect(page).to have_selector ".nrs0_status", text: "体動時"
    expect(page).to have_selector ".nrs0_supplement", text: "鈍い痛み"
    expect(page).to have_selector ".nrs6_rating", text: "1"
    expect(page).to have_selector ".nrs6_status", text: "安静時"
    expect(page).to have_selector ".nrs6_supplement", text: "痺れる痛み"
  end

  scenario "edit patient nrs" do
    visit patient_nrs_scales_path second_patient
    find(".nrs0_edit_link").click
    expect(page).to have_current_path edit_patient_nrs_scale_path(
      second_patient, second_patient_latest_nrs_scale
    )
    fill_in "NRS", with: "8"
    select "荷重時", from: "nrs_scale[status]"
    fill_in "補足", with: "痺れる痛み"
    click_on "保存する"
    expect(page).to have_current_path patient_nrs_scales_path(second_patient)
    expect(page).to have_selector ".nrs0_rating", text: "8"
    expect(page).to have_selector ".nrs0_status", text: "荷重時"
    expect(page).to have_selector ".nrs0_supplement", text: "痺れる痛み"
  end

  scenario "destory patient nrs", js: true do
    visit patient_nrs_scales_path second_patient
    page.accept_confirm do
      find(".nrs0_delete_link").click
    end
    expect(page).to have_current_path patient_nrs_scales_path second_patient
    expect(all(".nrs_score").size).to eq(6)
    expect(page).to have_selector ".nrs0_rating", text: "10"
    expect(page).to have_selector ".nrs0_status", text: "荷重時"
    expect(page).to have_selector ".nrs0_supplement", text: "焼ける痛み"
  end
end
