class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user, :book).order(created_at: :desc)
  end
end
