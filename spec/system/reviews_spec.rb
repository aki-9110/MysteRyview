require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  describe "ログイン前" do
    context "投稿一覧へのアクセス" do
      it "すべてのユーザーの投稿が表示される" do
        visit reviews_path
        expect(page).to have_content "投稿一覧"
        expect(current_path).to eq reviews_path
      end
    end
  end
end
