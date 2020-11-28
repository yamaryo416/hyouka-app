require 'rails_helper'

RSpec.feature "BathyesthesiaScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_bathyesthesia) do
    create(:bathyesthesia_scale, right_upper_limb: "one",
                                 left_upper_limb: "two",
                                 right_lower_limb: "three",
                                 patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient bathyesthesia" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "深部感覚検査"
    expect(page).not_to have_selector ".defined-scale", text: "深部感覚検査"
    click_on "深部感覚検査"
    expect(page).to have_current_path new_patient_bathyesthesia_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "0/5", from: "bathyesthesia_scale[left_lower_limb]"
    select "4/5", from: "bathyesthesia_scale[right_finger]"
    select "3/5", from: "bathyesthesia_scale[left_toe]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "深部感覚検査"
    expect(page).not_to have_selector ".undefined-scale", text: "深部感覚検査"
    click_on "深部感覚検査"
    expect(page).to have_current_path patient_bathyesthesia_scales_path(first_patient)
    expect(page).to have_selector ".left_lower_limb_score", text: "0/5"
    expect(page).to have_selector ".right_finger_score", text: "4/5"
    expect(page).to have_selector ".left_toe_score", text: "3/5"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "深部感覚検査を編集する"
    expect(page).to have_link "深部感覚検査を削除する"
  end

  scenario "edit patient bathyesthesia" do
    visit patient_bathyesthesia_scales_path second_patient
    click_on "深部感覚検査を編集する"
    expect(page).to have_current_path edit_patient_bathyesthesia_scales_path second_patient
    select "5/5", from: "bathyesthesia_scale[right_upper_limb]"
    select "2/5", from: "bathyesthesia_scale[left_upper_limb]"
    select "1/5", from: "bathyesthesia_scale[right_lower_limb]"
    click_on "保存する"
    expect(page).to have_current_path patient_bathyesthesia_scales_path second_patient
    expect(page).to have_selector ".right_upper_limb_score", text: "5/5"
    expect(page).to have_selector ".left_upper_limb_score", text: "2/5"
    expect(page).to have_selector ".right_lower_limb_score", text: "1/5"
  end

  scenario "destory patient bathyesthesia", js: true do
    visit patient_bathyesthesia_scales_path second_patient
    page.accept_confirm do
      click_on "深部感覚検査を削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "深部感覚検査"
    expect(page).not_to have_selector ".defined-scale", text: "深部感覚検査"
  end
end
