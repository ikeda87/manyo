@user1 = User.create!(name: "user1",
             email: "user1@user.com",
             password: "password",
             password_confirmation: "password",
             admin: true
             )
             
User.create!(name: "user2",
             email: "user2@user.com",
             password: "password",
             password_confirmation: "password",
             admin: true
             )

8.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false
               )
end

10.times do |n|
  Label.create!(name: "ラベル#{n + 1}",
                user_id: 1)
end

10.times do |n|
  @user1.tasks.create!(title: "タスク#{n + 1}",
               content: "文章#{n + 1}",
               deadline: "002021-02-22",
               status: "未着手",
               priority: "高",
              )
end
