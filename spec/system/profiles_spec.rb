require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }
  before do
    login(user)
    click_link "マイページ"
    sleep 0.5
  end

  describe "プロフィール編集" do
    it "プロフィールの詳細にアクセスできる" do
      expect(current_path).to eq(profile_path)
    end

    it "プロフィールを編集できる" do
      click_link "編集する"
      fill_in "ユーザー名", with: "編集後のuser"
      click_button "更新する"
      sleep 0.5
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("ユーザーを更新しました")
      expect(page).to have_content("編集後のuser")
    end

    it "プロフィールの編集に失敗する" do
      click_link "編集する"
      fill_in "ユーザー名", with: ""
      click_button "更新する"
      expect(current_path).to eq(edit_profile_path)
      expect(page).to have_content("ユーザーの更新に失敗しました")
    end
  end
end
