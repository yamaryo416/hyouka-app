require 'rails_helper'

RSpec.feature "Therapists", type: :feature do
  let!(:admin) do
    create(:therapist, :admin, unique_id: "12345678",
                               first_name: "鈴木",
                               last_name: "太郎")
  end
  let!(:therapist) do
    create(:therapist, unique_id: "87654321",
                       first_name: "佐藤",
                       last_name: "花")
  end
  let!(:therapists) do
    create_list(:therapist, 5)
  end

  scenario "login admin" do
    visit root_url
    expect(page).to have_current_path root_url
    expect(page).to have_selector ".page-title", text: "ログイン"
    fill_in "ユーザーID", with: admin.unique_id
    fill_in "パスワード", with: admin.password
    click_button "ログイン"
    expect(page).to have_current_path patients_path
    expect(page).to have_link "鈴木 太郎"
    expect(page).to have_link "患者登録", count: 2
    expect(page).to have_link "ユーザー作成"
    expect(page).to have_link "ユーザー一覧"
    expect(page).not_to have_link "パスワードを変更する"
    expect(page).to have_link "ログアウト"
  end

  scenario "login therapist" do
    visit root_url
    expect(page).to have_current_path root_url
    fill_in "ユーザーID", with: therapist.unique_id
    fill_in "パスワード", with: therapist.password
    click_button "ログイン"
    expect(page).to have_current_path patients_path
    expect(page).to have_link "佐藤 花"
    expect(page).to have_link "患者登録", count: 2
    expect(page).not_to have_link "ユーザー作成"
    expect(page).not_to have_link "ユーザー一覧"
    expect(page).to have_link "パスワードを変更する"
    expect(page).to have_link "ログアウト"
  end

  scenario "create therapist" do
    sign_in admin
    visit patients_path
    click_on "ユーザー作成"
    expect(page).to have_current_path signup_path
    expect(page).to have_selector ".page-title", text: "ユーザー作成"
    fill_in "性", with: "飯田"
    fill_in "名", with: "香奈"
    fill_in "ユーザーID", with: "11111111"
    fill_in "パスワード", with: "password"
    fill_in "確認用パスワード", with: "password"
    click_button "ユーザー登録"
    expect(all(".therapist-box").size).to eq 8
  end

  scenario "index therapist page" do
    sign_in admin
    visit patients_path
    click_on "ユーザー一覧"
    expect(page).to have_current_path admin_therapists_path
    expect(page).to have_selector ".page-title", text: "ユーザー一覧"
    expect(all(".therapist-box").size).to eq 7
    expect(page).to have_link "ユーザー作成", count: 2
  end

  scenario "show therapist page" do
    sign_in admin
    visit admin_therapists_path
    click_on "佐藤 花"
    expect(page).to have_current_path admin_therapist_path therapist
    expect(page).to have_selector ".therapist-id", text: "87654321"
    expect(page).to have_selector ".therapist-name", text: "佐藤 花"
    expect(page).to have_link "ユーザー一覧に戻る"
    expect(page).to have_link "ユーザーを削除する"
  end

  scenario "show admin therapist page" do
    sign_in admin
    visit admin_therapist_path admin
    expect(page).to have_selector ".page-title", text: "鈴木 太郎"
    expect(page).to have_selector ".therapist-id", text: "12345678"
    expect(page).to have_selector ".therapist-name", text: "鈴木 太郎"
    expect(page).to have_link "ユーザー一覧に戻る"
    expect(page).not_to have_link "ユーザーを削除する"
  end

  scenario "show therapist page" do
    sign_in admin
    visit admin_therapists_path
    click_on "佐藤 花"
    expect(page).to have_current_path admin_therapist_path therapist
    expect(page).to have_selector ".page-title", text: "佐藤 花"
    expect(page).to have_selector ".therapist-id", text: "87654321"
    expect(page).to have_selector ".therapist-name", text: "佐藤 花"
    expect(page).to have_link "ユーザー一覧に戻る"
    expect(page).to have_link "ユーザーを削除する"
  end

  scenario "edit therapist password" do
    sign_in therapist
    visit patients_path
    click_on "パスワードを変更する"
    expect(page).to have_current_path edit_therapist_registration_path
    expect(page).to have_selector ".page-title", text: "パスワード編集"
    fill_in "パスワード", with: "hogehoge"
    fill_in "確認用パスワード", with: "hogehoge"
    fill_in "現在のパスワード", with: "password"
    click_on "パスワード編集"
    expect(page).to have_current_path patients_path
  end

  scenario "delete therapist", js: true do
    sign_in admin
    visit admin_therapist_path therapist
    page.accept_confirm do
      click_on "ユーザーを削除する"
    end
    expect(all(".therapist-box").size).to eq 6
  end
end
