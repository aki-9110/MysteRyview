class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_review, only: [ :edit, :update ]

  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).includes(:user, :book).order(created_at: :desc).page(params[:page])
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
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit
  end

  def update
    book = Book.find_or_create_by(title: review_params[:book_title], author: review_params[:book_author])

    if @review.update(
      book_id: book.id,
      non_spoiler_text: review_params[:non_spoiler_text],
      spoiler_text: review_params[:spoiler_text],
      foreshadowing: review_params[:foreshadowing],
      rating: review_params[:rating],
      image: review_params[:image]
    )
      redirect_to review_path(@review), success: t("defaults.flash_message.updated", item: Review.model_name.human)
    else
      flash.now[:error] = t("defaults.flash_message.not_updated", item: Review.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    review = current_user.reviews.find(params[:id])
    review.destroy!
    redirect_to reviews_path, success: t("defaults.flash_message.deleted", item: Review.model_name.human), status: :see_other
  end

  def spoiler
    @review = Review.includes(:user, :book).find(params[:id])
  end

  private

  def set_review
    @review = current_user.reviews.includes(:user, :book).find(params[:id])
  end

  def review_params
    params.require(:review).permit(:book_title, :book_author, :non_spoiler_text, :spoiler_text, :foreshadowing, :rating, :image)
  end
end
