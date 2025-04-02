class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }

  has_many :reviews

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "author", "created_at", "updated_at", "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "reviews" ]
  end
end
