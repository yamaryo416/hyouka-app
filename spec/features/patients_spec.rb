require 'rails_helper'

RSpec.feature "Patients", type: :feature do
  let!(:admin) { create(:therapist, :admin) }
  let!(:therapist) { create(:therapist) }
  let!(:admin_patients) { create_list(:patient, 3, therapist: admin) }
  let!(:therapist_patients) { create_list(:patient, 3, therapist: therapist) }
  let!(:admin_patient) do
    create(:patient, first_name: "佐藤",
                     last_name: "花子",
                     sex: :woman,
                     age: 20,
                     height: 170.0,
                     weight: 60.0,
                     therapist: admin)
  end

  context "login as admin" do
    before do
      sign_in admin
      visit patients_path
    end

    scenario "show index page" do
      expect(page).to have_current_path patients_path
      expect(page).to have_selector ".page-title", text: "患者一覧"
      expect(page).to have_selector ".top-breadcrumb-item", text: "患者一覧"
      expect(page).to have_link "患者登録", count: 2
      expect(all(".patient-box").size).to eq 7
    end

    scenario "create a new patient" do
      find(".new-patient-link a").click
      expect(page).to have_current_path new_patient_path
      expect(page).to have_selector ".page-title", text: "患者登録"
      expect(page).to have_selector ".top-breadcrumb-item", text: "患者一覧"
      expect(page).to have_selector ".under-breadcrumb-item", text: "患者登録"
      fill_in "性", with: "鈴木"
      fill_in "名", with: "太郎"
      select "男性", from: "patient[sex]"
      fill_in "年齢", with: 20
      fill_in "体重", with: 60.0
      fill_in "身長", with: 170.0
      click_on "登録"
      visit patients_path
      expect(all(".patient-box").size).to eq 8
    end

    scenario "show patient page" do
      click_on "佐藤 花子"
      expect(page).to have_current_path patient_path admin_patient
      expect(page).to have_selector ".page-title", text: "患者ページ"
      expect(page).to have_selector ".top-breadcrumb-item", text: "患者一覧"
      expect(page).to have_selector ".middle-breadcrumb-item", text: "佐藤 花子"
      expect(page).to have_selector ".name", text: "佐藤 花子"
      expect(page).to have_selector ".sex", text: "女性"
      expect(page).to have_selector ".age", text: "20"
      expect(page).to have_selector ".height", text: "170.0"
      expect(page).to have_selector ".weight", text: "60.0"
      expect(all(".undefined-scale").size).to eq 13
      expect(page).to have_link "基本情報を編集する"
      expect(page).to have_link "患者情報を削除する"
    end

    scenario "edit patient page" do
      visit patient_path admin_patient
      click_on "基本情報を編集する"
      expect(page).to have_current_path edit_patient_path admin_patient
      expect(page).to have_selector ".page-title", text: "患者編集"
      expect(page).to have_selector ".top-breadcrumb-item", text: "患者一覧"
      expect(page).to have_selector ".middle-breadcrumb-item", text: "佐藤 花子"
      select "男性", from: "patient[sex]"
      fill_in "年齢", with: 30
      fill_in "身長", with: 175.0
      fill_in "体重", with: 70.0
      click_on "編集"
      expect(page).to have_selector ".sex", text: "男性"
      expect(page).to have_selector ".age", text: "30"
      expect(page).to have_selector ".height", text: "175.0"
      expect(page).to have_selector ".weight", text: "70.0"
    end

    scenario "destroy patient", js: true do
      visit patient_path admin_patient
      page.accept_confirm do
        click_on "患者情報を削除する"
      end
      expect(all(".patient-box").size).to eq 6
    end
  end

  context "login as therapist" do
    before do
      sign_in therapist
      visit patients_path
    end

    scenario "show index page" do
      expect(page).to have_current_path patients_path
      expect(all(".patient-box").size).to eq 3
    end
  end
end
