class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, uniqueness: { scope: :review_id }

  # いいねがデータベースへ保存された後に通知を作成するメソッドを実行
  after_create_commit :create_notification_like

  private

  def create_notification_like
    Notification.create(visitor_id: self.user_id, visited_id: self.review.user_id, notifiable: self, action: "like")
  end
end
