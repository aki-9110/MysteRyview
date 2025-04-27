class TopsController < ApplicationController
  def top
    @new_reviews = Review.includes({ user: { avatar_attachment: :blob } }, :book, :likes, image_attachment: :blob).order(created_at: :desc).limit(4)
  end
end
