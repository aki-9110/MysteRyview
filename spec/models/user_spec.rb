require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:review) { create(:review, user: user) }

  describe "ユーザー新規登録" do
    context "新規登録できる時" do
      it "全ての項目が入力されていれば登録できる" do
        expect(user).to be_valid
      end
    end

    context "nameが無効で登録できない場合" do
      it "nameが空の場合は登録できない" do
        user.name = ""
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("ユーザー名を入力してください")
      end
    end

    context "emailが無効で登録できない場合" do
      it "emailが空の場合は登録できない" do
        user.email = ""
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it "emailは重複して登録できない" do
        create(:user, email: "sample_1@example.com")
        user2 = build(:user, email: "sample_1@example.com")
        expect(user2).to be_invalid
        expect(user2.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it "emailのフォーマットが不正の場合は登録できない" do
        user.email = "aaa"
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("メールアドレスは不正な値です")
      end
    end

    context "passwordが無効で登録できない" do
      it "passwordが空の場合は登録できない" do
        user.password = ""
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "passwordが6文字未満の場合は登録できない" do
        user.password = "a" * 5
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it "passwordとpassword_confirmationが一致しない場合は登録できない" do
        user.password_confirmation = "a" * 6
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end

  describe "関連付けのテスト" do
    it "ReviewがUserに属していること" do
      expect(review.user).to eq(user)
    end
  end
end
