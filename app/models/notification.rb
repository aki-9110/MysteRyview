class Notification < ApplicationRecord
  belongs_to :visitor, class_name: "User"  # 通知を送ったユーザー
  belongs_to :visited, class_name: "User" # 通知を受け取るユーザー

  # LikeモデルとCommentモデルへのポリモーフィック関連付け
  belongs_to :notifiable, polymorphic: true
end
