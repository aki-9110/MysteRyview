require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let!(:user) { create(:user) }

  context 'フォームが未入力' do
    it 'ログイン処理が失敗する' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログイン'
      expect(current_path).to eq new_user_session_path
    end
  end

  describe "ログイン前" do
    context "フォームの入力値が正常" do
      it "ログインできる" do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(page).to have_content 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end
end
