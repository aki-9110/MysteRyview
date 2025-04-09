class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update email_edit]

  def show
    @user = User.find(current_user.id)
  end

  def edit

  end
end