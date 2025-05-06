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
      step_form_book
      step_form_non_spoiler
      step_form_spoiler
      fill_in "タグ", with: "クローズド"
      click_button "投稿する"
      sleep 0.5
      click_link "レビューを見る"
      expect(page).to have_content "クローズド"
    end
  end
end
