class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum task_status:{未着手:1, 着手中:2, 完了:3}
  enum priority:{低:1, 中:2, 高:3}
  scope :sort_created_at, -> { order(created_at: "DESC") }
  scope :sort_deadline, -> { order(deadline: "DESC") }
  scope :sort_priority, -> { order(priority: "DESC") }
  scope :search_title, -> (title){ where("title LIKE?","%#{title}%") }
  # scope :search_title, -> (params){ where("title LIKE?","%#{params}%") }
  scope :search_status, -> (status){ where(status: status) }
  scope :pagination, -> (params){ page(params[:page]).per(5) }
end
