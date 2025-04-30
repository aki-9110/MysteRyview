require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:book) { create(:book) }
  let!(:review) { create(:review, user: user_2, book: book) }

  it "ユーザー1がいいねすると、ユーザー2に通知が届く" do
    # ユーザー1でログインしていいね
    login(user)
    sleep 0.5
    click_link "投稿一覧"
    sleep 0.5
    find("#like-button-for-review-#{review.id}").click
    click_link "ログアウト"

    # ユーザー2でログインして通知確認
    click_link "ログイン"
    sleep 0.5
    fill_in "メールアドレス", with: user_2.email
    fill_in "パスワード", with: user_2.password
    click_button "ログイン"
    click_link "マイページ"
    sleep 0.5
    click_link "通知"
    sleep 0.5
    expect(page).to have_content("sample_user さんが あなたのレビュー に いいね しました")
  end
end
