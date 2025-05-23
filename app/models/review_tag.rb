class ReviewTag < ApplicationRecord
  belongs_to :review
  belongs_to :tag

  validates :review_id, presence: true
  validates :tag_id, presence: true, uniqueness: { scope: :review_id }
end
