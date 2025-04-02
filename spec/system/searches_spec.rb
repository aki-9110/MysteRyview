require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let(:user) { create(:user) }
  let(:book1) { Book.create(title: "そして誰もいなくなった", author: "アガサ・クリスティー") }
  let(:book2) { Book.create(title: "ハリー・ポッター", author: "J.K.ローリング") }
  let!(:matching_review) { create(:review, book: book1, user: user) }
  let!(:non_matching_review) { create(:review, book: book2, user: user) }

  before do
    login(user)
    visit reviews_path
  end

  context "検索フォームで検索" do
    it "検索結果に該当するレビューが表示される" do
      fill_in "q[book_title_or_book_author_cont]", with: "そして誰もいなくなった"
      click_button "検索"
      expect(page).to have_content("そして誰もいなくなった")
      expect(page).to have_content("アガサ・クリスティー")
      expect(page).not_to have_content("ハリー・ポッター")
      expect(page).not_to have_content("J.K.ローリング")
    end
  end
end
