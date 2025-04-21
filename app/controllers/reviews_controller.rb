class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_review, only: [ :edit, :update ]

  def index
    review_tag = Review.include_tag(params[:tag_name])
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).includes(:user, :book).merge(review_tag).order(created_at: :desc).page(params[:page])
  end

  def new
    @review = Review.new
  end


  def create
    @review = current_user.reviews.build_with_book(review_params)

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

  def edit
  end


  def update
    if @review.update_with_book(review_params)
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
    @comment = Comment.new
    @comments = @review.comments.includes(:user).order(created_at: :desc)
  end

  private

  def set_review
    @review = current_user.reviews.includes(:user, :book).find(params[:id])
  end

  def review_params
    params.require(:review).permit(:book_title, :book_author, :non_spoiler_text, :spoiler_text, :foreshadowing, :rating, :image, :tag_names)
  end
end
