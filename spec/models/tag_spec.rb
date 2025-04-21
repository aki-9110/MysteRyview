require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "バリデーション" do
    it "nameがあれば有効である" do
      tag = build(:tag)
      expect(tag).to be_valid
    end

    it "nameがなければ無効である" do
      tag = build(:tag, name: "")
      expect(tag).not_to be_valid
    end

    it "同じnameのタグは保存できない" do
      tag = create(:tag)
      new_tag = tag = build(:tag, name: tag.name)
      expect(new_tag).not_to be_valid
    end
  end
end
