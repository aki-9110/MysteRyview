class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @reviews = Review.includes(:user, :book).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def create
    book = Book.find_or_create_by(title: review_params[:book_title], author: review_params[:book_author])
    @review = current_user.reviews.build(
      book_id: book.id,
      non_spoiler_text: review_params[:non_spoiler_text],
      spoiler_text: review_params[:spoiler_text],
      foreshadowing: review_params[:foreshadowing],
      rating: review_params[:rating],
      image: review_params[:image]
    )
    if @review.save
      redirect_to reviews_path, success: t("defaults.flash_message.created", item: Review.model_name.human)
    else
      flash[:alert] = t("defaults.flash_message.input_error")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @review = Review.includes(:user, :book).find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:book_title, :book_author, :non_spoiler_text, :spoiler_text, :foreshadowing, :rating, :image)
  end
end
