require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  describe "本の登録" do
    context "登録に成功する" do
      it "全ての項目が入力されていれば登録できる" do
        expect(book).to be_valid
      end
    end

    context "未入力項目がある時、登録に失敗する" do
      it "titleが未入力の場合登録できない" do
        book.title = ""
        expect(book).to be_invalid
        expect(book.errors.full_messages).to include("本のタイトルを入力してください")
      end

      it "authorが未入力の場合登録できない" do
        book.author = ""
        expect(book).to be_invalid
        expect(book.errors.full_messages).to include("著者を入力してください")
      end
    end

    context "入力値が不正の時、登録できない" do
      it "titleが長すぎる場合" do
        book.title = "a" * 256
        expect(book).to be_invalid
        expect(book.errors.full_messages).to include("本のタイトルは255文字以内で入力してください")
      end

      it "Authorが長すぎる場合" do
        book.author = "a" * 256
        expect(book).to be_invalid
        expect(book.errors.full_messages).to include("著者は255文字以内で入力してください")
      end
    end
  end
end
