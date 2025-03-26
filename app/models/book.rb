class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :author, presence: true, uniqueness: true, length: { maximum: 255 }

  has_many :reviews
end
