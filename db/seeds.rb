  10.times do |n|
    title = Faker::Pokemon.name
  end

  10.times do |n|
    @user1.tasks.create!(title: "タスク#{n + 1}",
                 content: "文章#{n + 1}",
                 deadline: "002022-02-22",
                 status: "未着手",
                 priority: "高",
                )
  end
