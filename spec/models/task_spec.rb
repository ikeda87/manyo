require 'rails_helper'
RSpec.describe Task, type: :model do
  let(:admin_user) { FactoryBot.create(:admin_user) }

    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗テスト', deadline:'002020-01-01', status:'未着手', priority:'高')
          expect(task).not_to be_valid
        end
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '', deadline:'002020-01-01', status:'未着手', priority:'高')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # task = Task.new(title: '成功テスト', content: '成功テスト', deadline:'002020-01-01', status:'未着手', priority:'高', user_id:'1')
        task = admin_user.tasks.new(title: 'test', content:'test', deadline:'002020-01-01', status:'未着手', priority:'高', user_id: '1' )
        expect(task).to be_valid
      end
    end

    describe 'タスクモデル機能', type: :model do
      describe '検索機能' do
      before do
        @user = FactoryBot.create(:user2_user)
        @task1 = FactoryBot.create(:task,title: 'task1',status: '着手中', user: @user)
        @task2 = FactoryBot.create(:second_task,title: 'sample', status: '着手中', user: @user)
        @task3 = FactoryBot.create(:third_task,title: 'example', status: '着手中', user: @user)
      end

      context 'scopeメソッドでタイトルの検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('task1')).to include(@task1)
        expect(Task.search_title('task1')).not_to include(@task2)
        expect(Task.search_title('task1')).not_to include(@task3)
        expect(Task.search_title('task1').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('着手中')).to include(@task1)
        expect(Task.search_status('着手中')).to include(@task2)
        expect(Task.search_status('着手中')).to include(@task3)
        expect(Task.search_status('着手中').count).to eq 3
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      expect(Task.search_title('task1').search_status('着手中')).to include(@task1)
      expect(Task.search_title('task1').search_status('着手中')).not_to include(@task2)
      expect(Task.search_title('task1').search_status('着手中')).not_to include(@task3)
      expect(Task.search_title('task1').search_status('着手中').count).to eq 1
        end
      end
    end
   end
  end
