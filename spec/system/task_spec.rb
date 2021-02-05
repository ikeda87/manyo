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
      it 'test' do
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
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

    # context 'タイトルであいまい検索をした場合' do
    #   it "検索キーワードを含むタスクで絞り込まれる" do
    #     visit tasks_path
    #     # タスクの検索欄に検索ワードを入力する (例: task)
    #     # 検索ボタンを押す
    #     fill_in 'name', with: 'task'
    #     click_on '検索'
    #     expect(page).to have_content 'task'
    #   end
    # end

    # context 'ステータス検索をした場合' do
    #   it "ステータスに完全一致するタスクが絞り込まれる" do
    #       visit tasks_path
    #     # ここに実装する
    #     # プルダウンを選択する「select」について調べてみること
    #   end
    # end

          # context 'ステータスのみで検索した場合' do
          #   it 'ステータスの検索結果が反映されたタスクが表示される' do
          #     visit tasks_path
          #     # select '着手中', from: 'task_status'
          #     find("option[value='着手中']").select_option
          #     click_on '検索'
          #     task = all('tbody tr')
          #     expect(task.first).to have_content 'タスク２'
          #   end
          # end

    # context 'タイトルのあいまい検索とステータス検索をした場合' do
    #   it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
    #     # ここに実装する
    #   end
    # end
end
# end
