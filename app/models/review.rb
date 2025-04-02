class Review < ApplicationRecord
  validates :non_spoiler_text, presence: true, length: { maximum: 500 }
  validates :spoiler_text, length: { maximum: 1000 }
  validates :foreshadowing, length: { maximum: 500 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user_id, presence: true
  validates :book_id, presence: true

  belongs_to :user
  belongs_to :book

  has_one_attached :image

  def self.ransackable_associations(auth_object = nil)
    [ "book" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "updated_at" ]
  end
end
