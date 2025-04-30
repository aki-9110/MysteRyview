require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "通知のバリデーション" do
    it "値が正常であれば有効" do
      notification = build(:notification)
      expect(notification).to be_valid
    end

    it "visitorがなければ無効" do
      notification = build(:notification, visitor: nil)
      expect(notification).not_to be_valid
    end

    it "visitedがなければ無効" do
      notification = build(:notification, visited: nil)
      expect(notification).not_to be_valid
    end

    it "notifiableがなければ無効" do
      notification = build(:notification, notifiable: nil)
      expect(notification).not_to be_valid
    end

    it "readはデフォルトでfalse" do
      notification = create(:notification)
      expect(notification.read).to eq(false)
    end
  end
end
