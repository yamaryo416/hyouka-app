require 'rails_helper'

RSpec.feature "BathyesthesiaScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_bathyesthesia) do
    create(:bathyesthesia_scale, right_upper_limb: "impaired",
                                 left_upper_limb: "impaired",
                                 right_lower_limb: "impaired",
                                 patient: second_patient)
  end
  let!(:oldest_third_patient_bathyesthesia) do
    create(:bathyesthesia_scale, right_upper_limb: "impaired",
                                 left_upper_limb: "impaired",
                                 right_lower_limb: "impaired",
                                 patient: third_patient)
  end
  let!(:third_patient_bathyesthesias) do
    create_list(:bathyesthesia_scale, 5, right_lower_limb: "impaired",
                                         patient: third_patient)
  end
  let!(:latest_third_patient_bathyesthesia) do
    create(:bathyesthesia_scale, left_lower_limb: "impaired",
                                 right_finger: "impaired",
                                 left_finger: "impaired",
                                 right_toe: "impaired",
                                 left_toe: "impaired",
                                 patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient bathyesthesia" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "深部感覚検査"
    expect(page).not_to have_selector ".defined-scale", text: "深部感覚検査"
    click_on "深部感覚検査"
    expect(page).to have_current_path new_patient_bathyesthesia_scale_path(
      first_patient
    )
    expect(page).to have_selector ".page-title", text: "深部感覚検査作成"
    select "鈍麻", from: "bathyesthesia_scale[left_lower_limb]"
    select "鈍麻", from: "bathyesthesia_scale[right_finger]"
    select "鈍麻", from: "bathyesthesia_scale[left_toe]"
    click_on "保存する"
    expect(page).to have_current_path patient_bathyesthesia_scales_path(
      first_patient
    )
    expect(page).to have_selector ".bathyesthesia0-limit-part-count",
                                  text: "3箇所"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient bathyesthesia" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "深部感覚検査"
    expect(page).not_to have_selector ".undefined-scale", text: "深部感覚検査"
    click_on "深部感覚検査"
    expect(page).to have_current_path patient_bathyesthesia_scales_path(
      second_patient
    )
    click_on "詳細"
    expect(page).to have_current_path patient_bathyesthesia_scale_path(
      second_patient, second_patient_bathyesthesia
    )
    expect(page).to have_selector ".page-title", text: "深部感覚検査"
    expect(page).to have_selector ".right_upper_limb_score", text: "鈍麻"
    expect(page).to have_selector ".left_upper_limb_score", text: "鈍麻"
    expect(page).to have_selector ".right_lower_limb_score", text: "鈍麻"
    expect(page).to have_link "深部感覚検査一覧"
    expect(page).to have_link "深部感覚検査を編集"
    expect(page).to have_link "深部感覚検査を削除"
  end

  scenario "index patient bathyesthesia" do
    visit patient_bathyesthesia_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "深部感覚検査一覧"
    expect(page).to have_selector ".bathyesthesia0-limit-part-count",
                                  text: "5箇所"
    expect(page).to have_selector ".bathyesthesia6-limit-part-count",
                                  text: "3箇所"
  end

  scenario "edit patient bathyesthesia" do
    visit patient_bathyesthesia_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_bathyesthesia_scale_path(
      second_patient, second_patient_bathyesthesia
    )
    expect(page).to have_selector ".page-title", text: "深部感覚検査編集"
    select "正常", from: "bathyesthesia_scale[right_upper_limb]"
    select "正常", from: "bathyesthesia_scale[left_upper_limb]"
    click_on "保存する"
    expect(page).to have_current_path patient_bathyesthesia_scales_path(
      second_patient
    )
    expect(page).to have_selector ".bathyesthesia0-limit-part-count",
                                  text: "1箇所"
    click_on "詳細"
    expect(page).to have_selector ".right_upper_limb_score", text: "正常"
    expect(page).to have_selector ".left_upper_limb_score", text: "正常"
  end

  scenario "destory patient bathyesthesia", js: true do
    visit patient_bathyesthesia_scales_path second_patient
    expect(page).to have_selector ".bathyesthesia0-limit-part-count",
                                  text: "3箇所"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).not_to have_selector ".bathyesthesia0-limit-part-count",
                                      text: "3箇所"
  end

  scenario "show patient page part of bathyesthesia" do
    visit patient_path second_patient
    expect(page).to have_selector ".bathyesthesia-limit-part-count", text: "機能低下: 3箇所"
    expect(page).to have_selector ".bathyesthesia-limit-part", text: "右上肢 左上肢 右下肢"
  end
end
