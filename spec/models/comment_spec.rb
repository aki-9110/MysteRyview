require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }

  describe "commentの登録" do
    context "登録に成功する" do
      it "入力が正常であれば登録できる" do
        expect(comment).to be_valid
      end
    end

    context "登録に失敗する" do
      it "未入力の場合" do
        comment.content = ""
        expect(comment).to be_invalid
      end

      it "contentが1文字の場合" do
        comment.content = "a"
        expect(comment).to be_invalid
      end

      it "contentが201文字以上の場合" do
        comment.content = "a" * 201
        expect(comment).to be_invalid
      end
    end
  end
end
