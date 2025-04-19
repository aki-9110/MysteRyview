require 'rails_helper'

RSpec.describe "Likes", type: :system do
  let(:user) { create(:user) }
  let!(:review) { create(:review) }
  let(:like) { create(:like, user: user, review: review) }

  describe "ログイン前" do
    it "いいねできない" do
      visit reviews_path
      find("i.fa-regular.fa-thumbs-up").click
      sleep 0.5
      expect(current_path).to eq new_user_session_path
    end
  end

  describe "ログイン後" do
    it "いいねできる" do
      login(user)
      sleep 0.5
      click_link "投稿一覧"
      find("#like-button-for-review-#{review.id}").click
      expect(page).to have_css("#unlike-button-for-review-#{review.id}")
    end

    it "いいねを外せる" do
      login(user)
      sleep 0.5
      click_link "投稿一覧"
      find("#unlike-button-for-review-#{like.review.id}").click
      expect(page).to have_css("#like-button-for-review-#{review.id}")
    end
  end
end
