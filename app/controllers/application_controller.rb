class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_unread_notifications_count
  allow_browser versions: :modern

  add_flash_types :success, :danger

  private def set_unread_notifications_count
    if user_signed_in?
      @unread_notifications_count = current_user.passive_notifications.where(read: false).count
    end
  end

  protected

  def configure_permitted_parameters
    # ユーザー登録時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :avatar ])
  end
end
