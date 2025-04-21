require 'rails_helper'

RSpec.describe "Tags", type: :system do
  let(:user) { create(:user) }

  describe "タグの新規作成" do
    before do
      login(user)
      sleep 0.5
      click_link "レビューを書く"
    end

    it "タグが保存できる" do
      fill_in "review[book_title]", with: "そして誰もいなくなった"
      fill_in "review[book_author]", with: "アガサクリスティー"
      fill_in "review[non_spoiler_text]", with: "すごかった！"
      fill_in "review[spoiler_text]", with: "犯人は〇〇です"
      fill_in "review[foreshadowing]", with: "右腕の傷"
      fill_in "review[rating]", with: 5
      fill_in "review[tag_names]", with: "クローズド"
      click_button "投稿する"
      sleep 0.5
      click_link "レビューを見る"
      expect(page).to have_content "クローズド"
    end
  end
end
