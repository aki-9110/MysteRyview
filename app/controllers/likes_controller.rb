class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    current_user.like(review)
    redirect_to reviews_path, success: t('.success')
  end

  def destroy
    like = current_user.likes.find(params[:id])
    review = like.review
    like.destroy!
    redirect_to reviews_path, success: t('.success'), status: :see_other
  end
end
