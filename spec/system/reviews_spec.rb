require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let!(:review) { create(:review, user: user, book: book) }

  describe "ログイン前" do
    context "投稿一覧へのアクセス" do
      it "すべてのユーザーの投稿が表示される" do
        visit reviews_path
        expect(page).to have_content "投稿一覧"
        expect(current_path).to eq reviews_path
      end
    end

    context '投稿が6件以下の場合' do
      let!(:reviews) { create_list(:review, 4) }
      it 'ページネーションが表示されない' do
        visit reviews_path
        expect(page).not_to have_selector('.pagination')
      end
    end

    context '投稿が7件以上ある場合' do
      let!(:reviews) { create_list(:review, 7) }
      it 'ページネーションが表示される' do
        visit reviews_path
        expect(page).to have_selector('.pagination')
      end
    end

    context "レビュー作成画面へアクセス" do
      it "ログイン画面へ遷移する" do
        visit new_review_path
        expect(page).to have_content "ログインもしくはアカウント登録してください。"
        expect(current_path).to eq new_user_session_path
      end

      it "ログインするとレビュー作成画面へ遷移する" do
        visit new_review_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
        expect(current_path).to eq new_review_path
      end
    end

    context "レビュー詳細画面へアクセス" do
      it "レビュー詳細画面へ遷移する" do
        visit review_path(review)
        expect(page).to have_content review.book.title
        expect(current_path).to eq review_path(review)
      end
    end

    context "レビュー編集画面へアクセス" do
      it "ログイン画面へ遷移する" do
        visit edit_review_path(review)
        expect(page).to have_content "ログインもしくはアカウント登録してください。"
        expect(current_path).to eq new_user_session_path
      end

      it "ログインするとレビュー編集画面へ遷移する" do
        visit edit_review_path(review)
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
        expect(current_path).to eq edit_review_path(review)
      end
    end

    context "ネタバレレビュー画面へアクセス" do
      it "ログイン画面へ遷移する" do
        visit spoiler_review_path(review)
        expect(page).to have_content "ログインもしくはアカウント登録してください。"
        expect(current_path).to eq new_user_session_path
      end

      it "ログインするとネタバレレビュー画面へ遷移する" do
        visit spoiler_review_path(review)
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
        expect(current_path).to eq spoiler_review_path(review)
      end
    end
  end

  describe "ログイン後" do
    before { login(user) }

    context "レビューを作成する" do
      it "レビュー作成画面へ遷移する" do
        click_link "レビューを書く"
        expect(page).to have_content "本のタイトル"
        expect(current_path).to eq new_review_path
      end

      it "項目を入力するとレビューが作成される" do
        click_link "レビューを書く"
        fill_in "review[book_title]", with: "そして誰もいなくなった"
        fill_in "review[book_author]", with: "アガサクリスティー"
        fill_in "review[non_spoiler_text]", with: "すごかった！"
        fill_in "review[spoiler_text]", with: "犯人は〇〇です"
        fill_in "review[foreshadowing]", with: "右腕の傷"
        choose "review[rating]", option: :excellent
        click_button "投稿する"
        expect(page).to have_content "レビューを投稿しました"
        expect(current_path).to eq reviews_path
        expect(page).to have_content "書籍: そして誰もいなくなった"
        expect(page).to have_content "著者: アガサクリスティー"
      end
    end

    context "未入力の項目がある" do
      it "投稿に失敗する" do
        click_link "レビューを書く"
        fill_in "review[book_title]", with: ""
        fill_in "review[book_author]", with: ""
        fill_in "review[non_spoiler_text]", with: ""
        fill_in "review[spoiler_text]", with: "犯人は〇〇です"
        fill_in "review[foreshadowing]", with: "右腕の傷"
        choose "review[rating]", option: :excellent
        click_button "投稿する"
        expect(page).to have_content "入力に誤りがあります"
        expect(current_path).to eq new_review_path
      end
    end

    context "レビューを編集する" do
      it "レビュー編集ページに遷移できる" do
        click_link "投稿一覧"
        find("i.fa-pen-to-square").click
        sleep 0.5
        expect(page).to have_content "レビュー編集"
        expect(current_path).to eq edit_review_path(review)
      end

      it "レビューを編集できる" do
        click_link "投稿一覧"
        find("i.fa-pen-to-square").click
        sleep 0.5
        fill_in "review[book_title]", with: "そして誰もいなくなった"
        fill_in "review[book_author]", with: "アガサクリスティー"
        fill_in "review[non_spoiler_text]", with: "すごかった！"
        fill_in "review[spoiler_text]", with: "犯人は〇〇です"
        fill_in "review[foreshadowing]", with: "右腕の傷"
        choose "review[rating]", option: :excellent
        click_button "投稿する"
        expect(page).to have_content "レビューを更新しました"
        expect(current_path).to eq review_path(review)
        expect(page).to have_content "書籍: そして誰もいなくなった"
        expect(page).to have_content "著者: アガサクリスティー"
      end
    end

    context "レビューを削除する" do
      it "レビューを削除できる" do
        click_link "投稿一覧"
        sleep 0.5
        accept_confirm I18n.t('defaults.delete_confirm') do
          find("a[href='#{review_path(review)}'] i.fa-trash-can").click
        end
        expect(page).to have_content "レビューを削除しました"
        expect(current_path).to eq reviews_path
        expect(page).not_to have_content review.book.title
      end
    end

    context "ネタバレレビュー画面へアクセスする" do
      it "ネタバレレビュー画面へ遷移する" do
        review
        click_link "投稿一覧"
        click_link "レビューを見る"
        accept_confirm "ネタバレが表示されますがよろしいですか？" do
          click_link "ネタバレ感想を見る"
        end
        sleep 1
        expect(page).to have_content review.spoiler_text
        expect(current_path).to eq spoiler_review_path(review)
      end
    end
  end
end
