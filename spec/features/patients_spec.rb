require 'rails_helper'

RSpec.feature "Patients", type: :feature do
  let!(:admin) { create(:therapist, :admin) }
  let!(:therapist) { create(:therapist) }
  let!(:admin_patient) { create(:patient, sex: :man, age: 20, weight: 60.0, height: 170.0, therapist: admin) }
  let!(:therapist_patient) { create(:patient, sex: :woman, age: 30, weight: 70.0, height: 180.0, therapist: therapist) }
  let!(:admin_patients) { create_list(:patient, 5, therapist: admin) }
  let!(:therapist_patients) { create_list(:patient, 5, therapist: therapist) }

  context "login as admin" do
    before do
      sign_in admin
      visit patients_path
    end

    scenario "show index page" do
      expect(page).to have_current_path patients_path
      expect(page).to have_link "患者登録"
      expect(page).to have_link admin_patient.unique_id
      expect(page).to have_link therapist_patient.unique_id
      expect(all(".patient-box").size).to eq 12
    end

    scenario "create a new patient" do
      click_on "患者登録"
      expect(page).to have_current_path new_patient_path
      fill_in "患者ID", with: "12345678"
      select "男性", from: "patient[sex]"
      fill_in "年齢", with: 20
      fill_in "体重", with: 60.0
      fill_in "身長", with: 170.0
      click_on "患者登録"
      visit patients_path
      expect(all(".patient-box").size).to eq 13
    end

    scenario "show patient page" do
      click_on admin_patient.unique_id
      expect(page).to have_current_path patient_path admin_patient
      expect(page).to have_content admin_patient.unique_id
      expect(page).to have_content admin_patient.sex_i18n
      expect(page).to have_content admin_patient.age
      expect(page).to have_content admin_patient.weight
      expect(page).to have_content admin_patient.height
      expect(page).to have_link "患者一覧に戻る"
      expect(page).to have_link "編集する"
      expect(page).to have_link "削除する"
    end

    scenario "edit patient page" do
      visit patient_path admin_patient
      click_on "編集する"
      expect(page).to have_current_path edit_patient_path admin_patient
      select "女性", from: "patient[sex]"
      fill_in "年齢", with: 30
      fill_in "体重", with: 70.0
      fill_in "身長", with: 175.0
      click_on "編集する"
      expect(page).to have_content "女性"
      expect(page).to have_content 30
      expect(page).to have_content 70.0
      expect(page).to have_content 175.0
    end

    scenario "destroy patient", js: true do
      visit patient_path admin_patient
      page.accept_confirm do
        click_on "削除する"
      end
      expect(page).to have_current_path patients_path
      expect(all(".patient-box").size).to eq 11
    end
  end

  context "login as therapist" do
    before do
      sign_in therapist
      visit patients_path
    end
    scenario "show index page" do
      expect(page).to have_current_path patients_path
      expect(page).to have_link "患者登録"
      expect(page).to have_link therapist_patient.unique_id
      expect(page).not_to have_link admin_patient.unique_id
      expect(all(".patient-box").size).to eq 6
    end
  end
end
