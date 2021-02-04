require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    before do
      FactoryBot.create(:task)
      @task = FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
    end

    describe '検索機能' do
    context 'タイトルで検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task_name', with: 'タスク01'
        fill_in 'task_content', with: 'タスク詳細01'
        fill_in 'task_deadline', with: '02021-01-22'
        select '着手中', from: 'task[status]'
        click_on '登録'
        expect(page).to have_content 'タスク01'
      end
    end
  end

  describe '一覧表示機能' do
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        # プルダウンを選択する「select」について調べてみること
        expect(page).to have_content 'task01'
      end
    end
    
    context 'タイトルの検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task3'
      end
    end
  end
end
