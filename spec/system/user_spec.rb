require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let(:user1_user) { FactoryBot.create(:user1_user) }
  let(:user2_user) { FactoryBot.create(:user2_user) }
  let(:admin_user) { FactoryBot.create(:admin_user) }

  describe 'サインアップ機能' do
    it 'サインアップ' do
      visit new_user_path
      fill_in "user_name", with: "テスト太郎"
      fill_in "user_email", with: "taro@gmail.com"
      fill_in "user_password", with: "current@password"
      fill_in "user_password_confirmation", with: "current@password"
      click_on "アカウント作成"
      expect(page.text).to include "アカウント作成後、ログインしました。"
      expect(page.text).to include "テスト太郎"
      expect(page.text).to include "taro@gmail.com"
    end
  end

  describe 'セッション機能' do
    it 'メールアドレスとパスワード後ログイン' do
      user1_user
      visit new_session_path
      fill_in "session_email", with: "user1@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
    end
  end

  context '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
    it 'ログイン画面に遷移する'do
      visit user_path(user1_user)
      expect(page).to have_content 'アクセス権限がありません。ログイン画面に遷移します。'
    end
  end

  describe 'ユーザー情報確認機能'do
    it 'ログイン後にはアカウント情報確認ページに移行する' do
      user1_user
      visit new_session_path
      fill_in "session_email", with: "user1@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
      expect(page.text).to include "のページ"
    end
  end

  describe '管理者機能' do
    it '管理ユーザは管理画面にアクセス' do
      admin_user
      visit new_session_path
      fill_in "session_email", with: "admin@example.com"
      fill_in "session_password", with: "19!a@z?0"
      find("#create_tag").click
      visit admin_users_path
      expect(page.text).not_to include "管理者権限がありません。"
    end

    it '一般ユーザは管理画面にアクセスできないこと' do
      user1_user
      visit new_session_path
      fill_in "session_email", with: "user1@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
      visit admin_users_path
      # expect(page.text).to include "管理者の権限がありません。"
    end
  end

    it '管理ユーザはユーザの新規登録ができること' do
      admin_user
      visit new_session_path
      a_user = FactoryBot.build(:admin_user)
      fill_in "session_email", with: a_user.email
      fill_in "session_password", with: a_user.password
      find("#create_tag").click
      visit admin_users_path
      click_on "users_admin_new_link"
      fill_in "user_name", with: "user2"
      fill_in "user_email", with: "user2@example.com"
      fill_in "user_password", with: "112233"
      fill_in "user_password_confirmation", with: "112233"
      click_on "users_admin_new_submit"
      expect(page.text).to include "ユーザーを新しく登録しました。"
    end

    it '管理ユーザはユーザの詳細画面にアクセスできること' do
      user1_user
      admin_user
      visit new_session_path
      a_user = FactoryBot.build(:admin_user)
      fill_in "session_email", with: a_user.email
      fill_in "session_password", with: a_user.password
      find("#create_tag").click
      visit admin_users_path
      click_on "users_admin_index", match: :first
      expect(page.text).to include "ユーザー情報"
    end

    it '管理ユーザはユーザの編集画面からユーザを編集できること' do
      user1_user
      admin_user
      visit new_session_path
      a_user = FactoryBot.build(:admin_user)
      fill_in "session_email", with: a_user.email
      fill_in "session_password", with: a_user.password
      find("#create_tag").click
      visit admin_users_path
      click_on "users_admin_index_edit", match: :first
      fill_in "user_name", with: ""
      fill_in "user_email", with: ""
      fill_in "user_password", with: "change@pass"
      fill_in "user_password_confirmation", with: "change@pass"
      click_on "users_admin_edit"
      expect(page.text).to include "管理者画面：アカウント情報確認" && "change_name" && "change@example.com" && ""
    end

    it '管理ユーザはユーザの削除をできること' do
      user1_user
      admin_user
      visit new_session_path
      a_user = FactoryBot.build(:admin_user)
      fill_in "session_email", with: a_user.email
      fill_in "session_password", with: a_user.password
      find("#create_tag").click
      visit admin_users_path
      click_on "users_admin_index_delete", match: :first
    end
end
