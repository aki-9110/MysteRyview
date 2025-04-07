require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "いいね機能" do
    context "user_idとreview_idの組み合わせがユニークな場合" do
      it "いいねできる" do
        like = build(:like)
        expect(like).to be_valid
      end
    end

    context "user_idとreview_idの組み合わせがユニークでない場合" do
      it "いいねに失敗する" do
        like = create(:like)
        new_like = build(:like, user: like.user, review: like.review)
        expect(new_like).to be_invalid
      end
    end
  end
end
