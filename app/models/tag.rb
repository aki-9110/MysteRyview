class Tag < ApplicationRecord
  has_many :review_tags, dependent: :destroy
  has_many :review, through: :review_tags

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
