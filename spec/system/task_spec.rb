# require 'rails_helper'
# RSpec.describe 'タスク管理機能', type: :system do
#   before do
#     FactoryBot.create(:task)
#     FactoryBot.create(:second_task)
#     FactoryBot.create(:third_task)
#     # @task = Task.create!(name: 'task')
#   end
#
#   describe '新規作成機能' do
#     context 'タスクを新規作成した場合' do
#       it '作成したタスクが表示される' do
#         visit new_task_path
#         fill_in "タイトル", with: "task1"
#         fill_in "詳細", with: "詳細2"
#         fill_in "終了期限", with: "002021-02-22"
#         select "着手中", from: "ステータス"
#         select "高", from: "優先度"
#         click_on '登録'
#         expect(page).to have_content 'task1'
#       end
#     end
#   end
#
#     describe '一覧表示機能' do
#       context '一覧画面に遷移した場合' do
#         it '作成済みのタスク一覧が表示される' do
#           task = FactoryBot.create(:task, title: 'task01', content: 'test', status: '着手中', deadline: '2022-02-22')
#           visit tasks_path
#           expect(page).to have_content 'task01'
#         end
#       end
#     end
#
#       context 'タスクが作成日時の降順に並んでいる場合' do
#         it '新しいタスクが一番上に表示される' do
#           visit tasks_path
#           task_list = all('.task_row')
#           expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのコンテンツ3'
#         end
#       end
#
#       context 'タスク終了期限をソートした場合' do
#         it '終了期限が最も近いタスクが一番上に表示される' do
#           visit tasks_path
#           fill_in "title", with: "step3"
#           click_on '終了期限'
#           task_list = all('.task_row')
#           expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのコンテンツ3'
#         end
#       end
#
#       context 'タスクを優先度でソートした場合' do
#       it '優先度が最も高いタスクが一番上に表示される' do
#         visit tasks_path
#         fill_in "title", with: "step3"
#         click_on '優先度'
#         task_list = all('.task_row')
#         expect(task_list[0]).to have_content 'title1'
#       end
#     end
#
#   describe '詳細表示機能' do
#      context '任意のタスク詳細画面に遷移した場合' do
#        it '該当タスクの内容が表示される' do
#          task = FactoryBot.create(:task, title: 'task01')
#          visit tasks_path
#          expect(page).to have_content 'task'
#        end
#      end
#   end
#
#   describe '検索機能' do
#      before do
#         FactoryBot.create(:task, title: "task")
#         FactoryBot.create(:second_task, title: "sample")
#         FactoryBot.create(:third_task,title: 'example', status: '着手中')
#      end
#   end
#
#   context 'タイトルを検索した場合' do
#     it '検索ワードを含んだタスクが表示される'do
#       visit tasks_path
#       fill_in "search_textarea", with:"title"
#       click_button 'search_btn'
#       expect(page).to have_content 'タスク名'
#     end
#   end
#
#   context 'ステータスを検索した場合' do
#     it '検索されたステータスのタスクが表示される'do
#       visit tasks_path
#       select "着手中", from: "status"
#       click_button 'search_btn'
#       expect(page).to have_content '着手中'
#     end
#   end
#
#     context 'タイトルとステータスを入力して検索した場合' do
#       it '検索ワードがタイトルに含まれ、かつ選択されたステータスが一致するタスクが絞られる'do
#         visit tasks_path
#           fill_in "search_textarea", with:"title1"
#           select "着手中", from: "status"
#           click_button 'search_btn'
#           expect(page).to have_content 'タスク名'
#       end
#     end
# end
