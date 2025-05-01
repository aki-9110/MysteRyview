class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 2, maximum: 200 }

  belongs_to :user
  belongs_to :review

  has_many :notifications, as: :notifiable, dependent: :destroy

  # コメントがデータベースへ保存された後に通知を作成するメソッドを実行
  after_create_commit :create_notification_comment

  private

  def create_notification_comment
    Notification.create(visitor_id: self.user_id, visited_id: self.review.user_id, notifiable: self, action: "comment")
  end
end
