class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user, :book).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def create
    book = Book.find_or_create_by(title: review_params[:title], author: review_params[:author])
    @review = current_user.reviews.build(
      book_id: book.id,
      non_spoiler_text: review_params[:non_spoiler_text],
      spoiler_text: review_params[:spoiler_text],
      foreshadowing: review_params[:foreshadowing],
      rating: review_params[:rating]
    )
    if @review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to reviews_path
    else
      flash[:alert] = "入力に誤りがあります"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :author, :non_spoiler_text, :spoiler_text, :foreshadowing, :rating)
  end
end
