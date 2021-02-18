class User < ApplicationRecord
  before_validation {email.downcase!}
  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, length: { maximum:255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length:{ minimum:6 }, on: :create
  has_many :tasks, dependent: :destroy
    has_many :labels, dependent: :destroy
  before_update :check_admin_count
  before_destroy :check_admin_count

  def check_admin_count
    @admin_count = User.where(admin: true).count
    user = User.find_by(id: self.id)
    if user.admin?
      if @admin_count < 2
        errors.add(:base, "最低1ユーザーは管理者権限を持つ必要がある。")
        throw :abort
      end
    end
  end
end

#   def admin_change_check
#     target = User.find_by(id: self.id)
#     if User.where(admin: true).count <= 2
#       if target.admin
#         throw :abort
#       end
#     end
#   end
# end
