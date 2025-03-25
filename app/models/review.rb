class Review < ApplicationRecord
  validates :non_spoiler_text, presence: true, length: { maximum: 500 }
  validates :spoiler_text, length: { maximum: 1000 }
  validates :foreshadowing, length: { maximum: 500 }
  validates :rating, presence: true

  belongs_to :user
  belongs_to :book
end
