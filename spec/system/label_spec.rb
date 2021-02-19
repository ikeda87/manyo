require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    user = FactoryBot.create(:user1_user)
    @task1 = FactoryBot.create(:task, user: user)
    @task2 = FactoryBot.create(:second_task, user: user)
    @label1 = FactoryBot.create(:label, user: user)
    @label2 = FactoryBot.create(:second_label, user: user)
    FactoryBot.create(:task_label, task: @task1, label: @label1)
    FactoryBot.create(:task_label, task: @task2, label: @label2)
      visit new_session_path
      fill_in "session_email", with: "user1@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
    end

  describe 'ラベル作成機能' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルがマイページに表示される'do
        visit new_label_path
        fill_in "ラベル名", with: "task"
        click_button '登録'
        expect(page).to have_content 'task'
      end
    end

    context 'ラベルを削除した場合' do
      it 'マイページのラベル一覧から消去される' do
        click_on 'my_page'
        label = Label.find_by(name: "ラベル1")
        page.accept_confirm do
          click_link '削除', href: label_path(label)
        end
        click_on 'my_page'
        expect(page).not_to have_content 'ラベル1'
      end
    end

  describe '検索機能' do
    context 'ラベルを検索した場合' do
      it '検索されたラベルが表示される' do
        select "ラベル1", from: "ラベル"
        click_button '検索'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'ラベル1'
        expect(task_list[0]).not_to have_content 'ラベル2'
      end
    end
  end
  # describe 'タスクとラベルの関連付けチェック' do
  #   context 'ラベルを付けてタスクを新規作成した場合' do
  #     it 'ラベル付きのタスクがタスク一覧画面に表示される' do
  #       visit new_task_path
  #       fill_in "タイトル", with: "タイトル１"
  #       fill_in "詳細", with: "詳細１"
  #       fill_in "終了期限", with: "002020-12-31"
  #       select "着手中", from: "ステータス"
  #       select "高", from: "優先度"
  #       check 'ラベル１'
  #       check 'ラベル２'
  #       click_button '登録する'
  #       visit tasks_path
  #       task_list = all('.task_row')
  #       expect(task_list[0]).to have_content 'ラベル１'
  #       expect(task_list[0]).to have_content 'ラベル２'
  #     end
  #   end
  #   context 'タスクを編集した場合' do
  #     it '任意のラベルの付け外しができる' do
  #       task = Task.find_by(title: "Factoryで作ったデフォルトのタイトル１")
  #       visit edit_task_path(task)
  #       check 'ラベル２'
  #       click_button '登録する'
  #       visit tasks_path
  #       task_list = all('.task_row')
  #       expect(task_list[1]).to have_content 'ラベル２'
  #     end
  #   end
  end
end
