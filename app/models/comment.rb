class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 2, maximum: 200 }

  belongs_to :user
  belongs_to :review
end
