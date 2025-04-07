class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_review, through: :likes, source: :review

  def own?(object)
    object&.user_id == id
  end

  def like(review)
    like_reviews << review 
  end

  def unlike(review)
    like_reviews.destroy(review)
  end

  def like?
    like_reviews.Include?(review)
  end
end
