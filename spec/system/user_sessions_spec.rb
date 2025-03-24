require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    context "フォームの入力値が正常" do
      it "ログインできる" do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
        expect(current_path).to eq root_path
      end
    end

    context "フォームが未入力" do
      it "ログイン処理が失敗する" do
        visit new_user_session_path
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        click_button "ログイン"
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "ログイン後" do
    context "ログインボタンを押す" do
      it "ログアウトできる" do
        login(user)
        click_link "ログアウト"
        expect(page).to have_content "ログアウトしました。"
        expect(current_path).to eq root_path
      end
    end
  end
end
