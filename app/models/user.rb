class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }
  validates :uid, uniqueness: { scope: :provider }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_reviews, through: :likes, source: :review

  # 自分が起こした通知 userのidと、notificationsテーブルのvisitor_idカラムが一致する通知を取得する
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy

  # 自分が受け取る通知 userのidと、notificationsテーブルのvisited_idカラムが一致する通知を取得する
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  has_one_attached :avatar

  def own?(object)
    object&.user_id == id
  end

  def like(review)
    like_reviews << review
  end

  def unlike(review)
    like_reviews.destroy(review)
  end

  def like?(review)
    like_reviews.include?(review)
  end

  # Oauthでログインする時、すでに登録のあるメールアドレスの場合既存のアカウントを探し、そうでなけるばユーザーを認証または作成する
  def self.from_omniauth(auth)
    find_by(email: auth.info.email) ||
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
