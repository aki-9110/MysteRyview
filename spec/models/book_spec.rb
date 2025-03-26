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
        expect(book.errors.full_messages).to include("Titleを入力してください")
      end

      it "authorが未入力の場合登録できない" do
        book.author = ""
        expect(book).to be_invalid
        expect(book.errors.full_messages).to include("Authorを入力してください")
      end
    end

    context "データが重複する時、登録に失敗する" do
      it "titleは重複して登録できない" do
        create(:book, title: "sample1_title")
        book2 = build(:book, title: "sample1_title")
        expect(book2).to be_invalid
        expect(book2.errors.full_messages).to include("Titleはすでに存在します")
      end

      it "authorは重複して登録できない" do
        create(:book, author: "sample1_title")
        book2 = build(:book, author: "sample1_title")
        expect(book2).to be_invalid
        expect(book2.errors.full_messages).to include("Authorはすでに存在します")
      end
    end

    context "入力値が不正の時、登録できない" do
      it "titleが長すぎる場合" do
        book.title = "a" * 256
        expect(book).to be_invalid
        expect(book.errors.full_messages).to include("Titleは255文字以内で入力してください")
      end

      it "Authorが長すぎる場合" do
        book.author = "a" * 256
        expect(book).to be_invalid
        expect(book.errors.full_messages).to include("Authorは255文字以内で入力してください")
      end
    end
  end
end
