FactoryBot.define do
  factory :task do
    title { 'title1' }
    content { 'Factoryで作ったデフォルトのコンテンツ1' }
    deadline { '002021-02-21' }
    status { '未着手' }
    priority { '高' }
  end

  factory :second_task, class: Task do
    title { 'title2' }
    content { 'Factoryで作ったデフォルトのコンテンツ2' }
    deadline { '002021-02-22' }
    status { '完了' }
    priority { '中' }
  end

  factory :third_task, class: Task do
    title { 'title3' }
    content { 'Factoryで作ったデフォルトのコンテンツ3' }
    deadline { '002021-02-23' }
    status { '着手中' }
    priority { '低' }
  end
end
