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
        puts "Capybara.app_host: #{Capybara.app_host}"
        puts "Rails server running on: #{Capybara.server_host}:#{Capybara.server_port}"
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

      context "入力が空の場合" do
        it "コメントの作成に失敗する" do
          fill_in "コメント", with: ""
          click_button "コメントする"
          expect(page).to have_content "コメントを入力してください"
        end
      end

      context "入力が1文字の場合" do
        it "コメントの作成に失敗する" do
          fill_in "コメント", with: "a"
          click_button "コメントする"
          expect(page).to have_content "コメントは2文字以上で入力してください"
        end
      end
    end

    describe "コメントの削除" do
      context "自分のコメントの場合" do
        it "コメントが削除できる" do
          accept_confirm I18n.t("defaults.delete_confirm") do
            sleep 0.5
            find("i.fa-solid.fa-trash-can.text-dullGold.fa-xl").click
          end
          expect(page).not_to have_content(comment_by_user1.content)
        end
      end

      context "他人のコメントの場合" do
        it "コメント削除ボタンが表示されない" do
          within "#comment-#{comment_by_user2.id}" do
            expect(page).not_to have_selector("i.fa-solid.fa-trash-can.text-dullGold.fa-xl")
          end
        end
      end
    end
  end
end
