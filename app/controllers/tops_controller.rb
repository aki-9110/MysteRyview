class TopsController < ApplicationController
  def top
    @new_reviews = Review.includes(:user, :book).order(created_at: :desc).limit(4)
  end
end
