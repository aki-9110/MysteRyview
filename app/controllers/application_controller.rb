class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern

  add_flash_types :success, :danger

  protected

  def configure_permitted_parameters
    # ユーザー登録時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end
end
