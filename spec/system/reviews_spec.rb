require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    context "投稿一覧へのアクセス" do
      it "すべてのユーザーの投稿が表示される" do
        visit reviews_path
        expect(page).to have_content "投稿一覧"
        expect(current_path).to eq reviews_path
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
        fill_in "review[rating]", with: 5
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
        fill_in "review[rating]", with: 5
        click_button "投稿する"
        expect(page).to have_content "入力に誤りがあります"
        expect(current_path).to eq new_review_path
      end
    end
  end
end
