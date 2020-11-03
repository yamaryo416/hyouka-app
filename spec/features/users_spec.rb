require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let!(:admin) { create(:user, :admin) }
  scenario "admin creates a new user" do
    visit login_path
    expect(page).to have_current_path login_path
    fill_in "ユーザーID", with: admin.user_id
    fill_in "パスワード", with: admin.password
    click_button "Log in"
    expect(page).to have_current_path root_path
    click_link "ユーザー作成"
    expect do
      fill_in "名前", with: "test user"
      fill_in "ユーザーID", with: "11111111"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: "password"
      click_button "Sign up"
    end.to change(User, :count).by 1
  end
end
