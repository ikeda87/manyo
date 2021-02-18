FactoryBot.define do
  factory :admin_user, class: User do
    name { "Administrator" }
    email { "admin@example.com" }
    password { "adminpassword" }
    password_confirmation { "adminpassword" }
    admin { "admin" }
  end

  factory :user1_user, class: User do
    name { "User1" }
    email { "user1@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { "not_admin" }
  end

  factory :user2_user, class: User do
    name { "User2" }
    email { "user2@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { "not_admin" }
  end
end
