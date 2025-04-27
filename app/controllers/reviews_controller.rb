class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show, :autocomplete ]
  before_action :set_current_user_review, only: [ :edit, :update ]
  before_action :set_review, only: [ :show, :spoiler ]

  def index
    review_tag = Review.include_tag(params[:tag_name])
    # タグのついていない投稿も表示させるためにleft_outer_joins(外部結合)を利用
    @q = Review.left_outer_joins(:tags).ransack(params[:q])
    @total_reviews_count = @q.result(distinct: true).count
    @reviews = @q.result(distinct: true).includes({user: { avatar_attachment: :blob }}, :book, :likes, image_attachment: :blob).merge(review_tag).order(created_at: :desc).page(params[:page])
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

  def show; end

  def edit
    @review.set_tag
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
    @comment = Comment.new
    @comments = @review.comments.includes({user: { avatar_attachment: :blob }}).order(created_at: :desc)
  end

  def autocomplete
    # Bookモデルから取得したタイトル・著者の重複を除く
    @books = Book.where("title LIKE :query OR author LIKE :query", query: "%#{params[:q]}%").distinct
    respond_to do |format|
      format.js
    end
  end

  private

  def set_current_user_review
    @review = current_user.reviews.includes(:book).find(params[:id])
  end

  def set_review
    @review = Review.includes({user: { avatar_attachment: :blob }}, :book, :likes, image_attachment: :blob).find(params[:id])
  end

  def review_params
    params.require(:review).permit(:book_title, :book_author, :non_spoiler_text, :spoiler_text, :foreshadowing, :rating, :image, :tag_names)
  end
end
