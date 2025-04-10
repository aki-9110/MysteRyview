require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:book) { create(:book) }
  let(:book2) { create(:book) }
  let!(:review_by_user) { create(:review, user: user, book: book) }
  let!(:review_by_user2) { create(:review, user: user2, book: book2) }

  before do
    login(user)
    click_link "マイページ"
    sleep 0.5
  end

  describe "プロフィール編集" do
    it "プロフィールの詳細にアクセスできる" do
      expect(current_path).to eq(profile_path)
    end

    it "プロフィールを編集できる" do
      click_link "編集する"
      fill_in "ユーザー名", with: "編集後のuser"
      click_button "更新する"
      sleep 0.5
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("ユーザーを更新しました")
      expect(page).to have_content("編集後のuser")
    end

    it "プロフィールの編集に失敗する" do
      click_link "編集する"
      fill_in "ユーザー名", with: ""
      click_button "更新する"
      expect(current_path).to eq(edit_profile_path)
      expect(page).to have_content("ユーザーの更新に失敗しました")
    end
  end

  describe "自分の投稿一覧" do
    it "自分の投稿だけが表示される" do
      click_link "自分の投稿"
      sleep 0.5
      expect(current_path).to eq(my_reviews_profile_path)
      expect(page).to have_content(review_by_user.book.title)
      expect(page).not_to have_content(review_by_user2.book.title)
    end
  end
end
