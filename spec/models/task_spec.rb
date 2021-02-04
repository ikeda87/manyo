require 'rails_helper'
RSpec.describe Task, type: :model do
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
  before do
    @task1 = FactoryBot.create(:task,title: 'task',status: '完了')
    @task2 = FactoryBot.create(:second_task,title: 'sample', status: '着手中')
    @task3 = FactoryBot.create(:third_task,title: 'example', status: '着手中')
  end
    # 必要に応じて、テストデータの内容を変更して構わない
    # let!(:task) { FactoryBot.create(:task, title: 'task') }
    # let!(:second_task) { FactoryBot.create(:second_task, title: "sample") }
    context 'scopeメソッドでタイトルの検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
      expect(Task.search_title('タスク１')).to include(@task1)
      expect(Task.search_title('タスク１')).not_to include(@task2)
      expect(Task.search_title('タスク１')).not_to include(@task3)
      expect(Task.search_title('タスク１').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
    expect(Task.search_status('着手中')).not_to include(@task1)
    expect(Task.search_status('着手中')).to include(@task2)
    expect(Task.search_status('着手中')).to include(@task3)
    expect(Task.search_status('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
    expect(Task.search_title('タスク３').search_status('完了')).to include(@task1)
    expect(Task.search_title('タスク３').search_status('完了')).not_to include(@task2)
    expect(Task.search_title('タスク３').search_status('完了')).not_to include(@task3)
    expect(Task.search_title('タスク３').search_status('完了').count).to eq 1
      end
    end
  end
 end
end
