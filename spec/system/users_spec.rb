require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe "ユーザー新規登録" do
    context "フォームの入力値が正常" do
      it "新規登録できる" do
        visit new_user_registration_path
        fill_in "ユーザー名", with: "sample_user"
        fill_in "メールアドレス", with: "sample_1@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "password"
        click_button "新規登録"
        expect(page).to have_content "ログアウト"
        expect(current_path).to eq root_path
      end
    end

    context "フォームの入力値が不正" do
      it "新規登録できない" do
        visit new_user_registration_path
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        fill_in "パスワード（確認用）", with: ""
        click_button "新規登録"
        expect(page).to have_content "3 件のエラーが発生したため ユーザ は保存されませんでした。"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "メールアドレスを入力してください"
        expect(page).to have_content "パスワードを入力してください"
        expect(current_path).to eq new_user_registration_path
      end
    end
  end
end
