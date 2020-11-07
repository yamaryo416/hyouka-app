require 'rails_helper'

RSpec.feature "Therapists", type: :feature do
  let!(:admin) { create(:therapist, :admin) }

  scenario "admin creates a new therapist" do
    visit login_path
    expect(page).to have_current_path login_path
    fill_in "ユーザーID", with: admin.unique_id
    fill_in "パスワード", with: admin.password
    click_button "Log in"
    expect(page).to have_current_path patients_path
    click_link "ユーザー作成"
    expect do
      fill_in "名前", with: "test therapist"
      fill_in "ユーザーID", with: "11111111"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: "password"
      click_button "Sign up"
    end.to change(Therapist, :count).by 1
  end
end
