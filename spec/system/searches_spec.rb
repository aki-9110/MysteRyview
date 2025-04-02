require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let!(:user) { create(:user) }
  let!(:matching_review) { create(:review, book_title: "そして誰もいなくなった", book_author: "アガサ・クリスティー", user: user) }
  let!(:non_matching_review) { create(:review, book_title: "ハリー・ポッター", book_author: "J.K.ローリング", user: user) }

  before do
    login(user)
    visit reviews_path
  end

  context "検索フォームで検索" do
    it "検索結果に該当するレビューが表示される" do
      fill_in "", with: "そして誰もいなくなった"
      click_button "検索" 
    end
  end
end
