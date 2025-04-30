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

  # 自分が投稿したレビューを取得
  def my_reviews
    @reviews = current_user.reviews.includes({ user: { avatar_attachment: :blob } }, :book, :likes, image_attachment: :blob).order(created_at: :desc).page(params[:page])
  end

  # 自分がいいねしたレビューを取得
  def my_likes
    @like_reviews = current_user.like_reviews.includes({ user: { avatar_attachment: :blob } }, :book, :likes, image_attachment: :blob).order(created_at: :desc).page(params[:page])
  end

  # 自分が受けた通知一覧を取得
  def my_notifications
    @notifications = current_user.passive_notifications.where(read: false).order(created_at: :desc).page(params[:page]).per(20)
  end

  # 通知を既読にしてレビューページに遷移する
  def notification
    notification_read_to_true
    redirect_to review_path(@notification.notifiable.review)
  end

  def read_notification
    notification_read_to_true
    redirect_to my_notifications_profile_path
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  def notification_params
    params.require(:notification).permit(:id)
  end

  def notification_read_to_true
    @notification = current_user.passive_notifications.find(notification_params[:id])
    @notification.update(read: true)
  end
end
