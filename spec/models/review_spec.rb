require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { build(:user) }
  let(:book) { build(:book) }
  let(:review) { build(:review, user: user, book: book) }

  
end
