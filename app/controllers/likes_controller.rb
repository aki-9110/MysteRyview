class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    current_user.like(@review)
  end

  def destroy
    @review = current_user.likes.find(params[:id]).review
    current_user.unlike(@review)
  end
end
