class Tag < ApplicationRecord
  has_many :review_tags, dependent: :destroy
  has_many :review, through: :review_tags

  validates :name, presence: true, uniqueness: true
end
