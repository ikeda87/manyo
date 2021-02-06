require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    # @task = Task.create!(name: 'task')
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: "task1"
        fill_in "詳細", with: "詳細2"
        fill_in "終了期限", with: "002021-02-22"
        select "着手中", from: "ステータス"
        select "高", from: "優先度"
        click_on '登録'
        expect(page).to have_content 'task1'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task01', content: 'test', status: '着手', deadline: '2022-02-22')
        visit tasks_path
        expect(page).to have_content 'task01'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task01')
         visit tasks_path
         expect(page).to have_content 'task'
       end
     end
  end

  describe '検索機能' do
     before do
        # 必要に応じて、テストデータの内容を変更して構わない
        FactoryBot.create(:task, title: "task")
        FactoryBot.create(:second_task, title: "sample")
        FactoryBot.create(:third_task,title: 'example', status: '着手中')
     end
  end

  context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        task = FactoryBot.create(:task, title: 'task1')
        visit tasks_path
        sleep 1
        # タスクの検索欄に検索ワードを入力する (例: task)
        # 検索ボタンを押す
        fill_in 'title', with: 'task1'
        click_on '検索'
        expect(page).to have_content 'task1'
    end
  end

  context 'ステータス検索をした場合' do
      it '検索されたステータスのタスクが表示される'do
        task = FactoryBot.create(:task, status: 'task1')
        visit tasks_path
        sleep 1
        select "着手中", from: "status"
        click_on '検索'
        expect(page).to have_content '着手中'
    end
  end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        task = FactoryBot.create(:task, title: 'task1', status: 'task1')
        visit tasks_path
        sleep 1
        fill_in "title", with:"task1"
        select "着手中", from: "status"
        click_on '検索'
        expect(page).to have_content '着手中'
      end
    end
end
