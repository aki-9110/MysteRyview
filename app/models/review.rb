class Review < ApplicationRecord
  validates :non_spoiler_text, presence: true, length: { maximum: 500 }
  validates :spoiler_text, length: { maximum: 1000 }
  validates :foreshadowing, length: { maximum: 500 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user_id, presence: true
  validates :book_id, presence: true

  belongs_to :user
  belongs_to :book
end
