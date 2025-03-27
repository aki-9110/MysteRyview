require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:review) { build(:review, user_id: user.id, book_id: book.id) }

  describe "レビュー投稿" do
    context "投稿できる" do
      it "全ての項目が入力されていれば投稿できる" do
        expect(review).to be_valid
      end

      it "spoiler_textが空でも投稿できる" do
        review.spoiler_text = ""
        expect(review).to be_valid
      end

      it "foreshadowingが空でも登録できる" do
        review.foreshadowing = ""
        expect(review).to be_valid
      end
    end

     context "投稿に失敗する" do
      it "non_spoiler_textが空の場合、投稿に失敗する" do
        review.non_spoiler_text = ""
        expect(review).to be_invalid
      end

      it "non_spoiler_textが長すぎる場合、投稿に失敗する" do
        review.non_spoiler_text = "a" * 501
        expect(review).to be_invalid
        expect(review.errors.full_messages).to include("感想・レビュー（ネタバレなし）は500文字以内で入力してください")
      end

      it "spoiler_textが長すぎる場合、投稿に失敗する" do
        review.spoiler_text = "a" * 1001
        expect(review).to be_invalid
        expect(review.errors.full_messages).to include("感想・レビュー★ネタバレありは1000文字以内で入力してください")
      end

      it "foreshadowingが長すぎる場合、投稿に失敗する" do
        review.foreshadowing = "a" * 501
        expect(review).to be_invalid
        expect(review.errors.full_messages).to include("気づいた伏線（未入力でも可）は500文字以内で入力してください")
      end

       it "ratingが空の場合、投稿に失敗する" do
        review.rating = ""
        expect(review).to be_invalid
        expect(review.errors.full_messages).to include("評価 (1〜5)を入力してください")
       end

       it "ratingが6以上の場合、投稿に失敗する" do
        review.rating = 6
        expect(review).to be_invalid
        expect(review.errors.full_messages).to include("評価 (1〜5)は5以下の値にしてください")
       end

      it "user_idが空の場合、投稿に失敗する" do
        review.user_id = nil
        expect(review).to be_invalid
      end

      it "book_idが空の場合、投稿に失敗する" do
        review.book_id = nil
        expect(review).to be_invalid
      end
     end
  end
end
