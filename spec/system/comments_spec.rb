require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:review) { create(:review) }
  let!(:comment_by_user1) { create(:comment, user: user1, review: review) }
  let!(:comment_by_user2) { create(:comment, user: user2, review: review) }

  describe "コメントのCRUD" do
    before do
      login(user1)
      click_link "投稿一覧"
      sleep(1)
      click_link "レビューを見る"
      accept_confirm "ネタバレが表示されますがよろしいですか？" do
        click_link "ネタバレ感想を見る"
      end
    end

    describe "コメントの一覧" do
      it "コメントの一覧が表示される" do
        expect(page).to have_content(comment_by_user1.content)
        expect(page).to have_content(comment_by_user2.content)
      end
    end

    describe "コメントの作成" do
      it "コメントの作成に成功する" do
        fill_in "コメント", with: "sample_comment"
        click_button "コメントする"
        expect(page).to have_content "sample_comment"
      end

      it "コメントの作成に失敗する" do
        fill_in "コメント", with: ""
        click_button "コメントする"
        expect(page).to have_content "コメントの投稿に失敗しました"
      end
    end
  end
end
