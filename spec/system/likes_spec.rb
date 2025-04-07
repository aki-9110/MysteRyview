require 'rails_helper'

RSpec.describe "Likes", type: :system do
  let(:user) { create(:user) }
  let!(:review) { create(:review) }

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
      find('[data-testid="unlike-button"]').click
      expect(page).to have_content("いいねしました")
    end

    it "いいねを外せる" do
      login(user)
      sleep 0.5
      click_link "投稿一覧"
      find('[data-testid="unlike-button"]').click
      find('[data-testid="like-button"]').click
      expect(page).to have_content("いいねしました")
    end
  end
end
