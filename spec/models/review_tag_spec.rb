require 'rails_helper'

RSpec.describe ReviewTag, type: :model do
  describe "バリデーション" do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:review) { create(:review, user_id: user.id, book_id: book.id) }
    let(:tag) { create(:tag) }
    context "review_idとtag_idの組み合わせがユニークな場合" do
      it "タグ付けできる" do
        review_tag = ReviewTag.new(review: review, tag: tag)
        expect(review_tag).to be_valid
      end
    end

    context "review_idとtag_idの組み合わせがユニークでない場合" do
      it "タグ付けに失敗する" do
        review_tag = ReviewTag.create(review: review, tag: tag)
        new_review_tag = ReviewTag.new(review: review_tag.review, tag: review_tag.tag)
        expect(new_review_tag).to be_invalid
      end
    end
  end
end
