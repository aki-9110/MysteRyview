class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit show update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t("defaults.flash_message.updated", item: User.model_name.human)
    else
      flash.now["danger"] = t("defaults.flash_message.not_updated", item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def my_reviews
    @reviews = current_user.reviews.includes({user: { avatar_attachment: :blob }}, :book, :likes, image_attachment: :blob).order(created_at: :desc).page(params[:page])
  end

  def my_likes
    @like_reviews = current_user.like_reviews.includes({user: { avatar_attachment: :blob }}, :book, :likes, image_attachment: :blob).order(created_at: :desc).page(params[:page])
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
